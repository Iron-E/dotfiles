-- SEE: https://github.com/actions/languageservices/tree/main/languageserver

--- @return string|nil
local function get_github_token()
	local handle = vim.system({ "gh", "auth", "token" }, {
		stderr = false,
		stdout = true,
		text = true,
	})

	local token = handle:wait().stdout

	if token == "" then
		return nil
	end

	return token
end

--- @param url string
--- @return string|nil
local function parse_github_remote(url)
	if not url or url == "" then
		return nil
	end

	-- SSH format: git@github.com:owner/repo.git
	local owner, repo = url:match("git@github%.com:([^/]+)/([^/%.]+)")
	if owner and repo then
		return owner, repo:gsub("%.git$", "")
	end

	-- HTTPS format: https://github.com/owner/repo.git
	owner, repo = url:match("github%.com/([^/]+)/([^/%.]+)")
	if owner and repo then
		return owner, repo:gsub("%.git$", "")
	end

	return nil
end

--- @class actionsls.RepoInfo
--- @field id number
--- @field organizationOwned boolean

--- @param owner string
--- @param repo string
--- @return actionsls.RepoInfo|nil
local function get_repo_info(owner, repo)
	local handle = vim.system({
		"gh",
		"repo",
		"view",
		owner .. "/" .. repo,
		"--json",
		"id,owner",
		"--template",
		"{{.id}}\t{{.owner.type}}",
	}, {
		stderr = false,
		stdout = true,
		text = true,
	})

	local result = handle:wait().stdout:gsub("%s+$", "")
	local id, owner_type = result:match("^(%d+)\t(.+)$")
	if id then
		return {
			id = tonumber(id),
			organizationOwned = owner_type == "Organization",
		}
	end

	return nil
end

--- @class actionsls.RepoConfig: actionsls.RepoInfo
--- @field owner string
--- @field name string
--- @field workspaceUri string

--- @return actionsls.RepoConfig[] | nil
local function get_repos_config()
	local handle = vim.system({ "git", "rev-parse", "--show-toplevel" }, {
		stderr = false,
		stdout = true,
		text = true,
	})

	local git_root = handle:wait().stdout:gsub("%s+", "")

	if git_root == "" then
		return nil
	end

	handle = vim.system({ "git", "remote", "get-url", "origin" }, {
		stderr = false,
		stdout = true,
		text = true,
	})

	local remote_url = handle:wait().stdout:gsub("%s+", "")

	local owner, name = parse_github_remote(remote_url)
	if not owner or not name then
		return nil
	end

	local info = get_repo_info(owner, name)

	return {
		{
			id = info and info.id or 0,
			owner = owner,
			name = name,
			organizationOwned = info and info.organizationOwned or false,
			workspaceUri = "file://" .. git_root,
		},
	}
end

return {
	cmd = { "actions-languageserver", "--stdio" },
	filetypes = { "yaml.ghactions" },

	-- `root_dir` ensures that the LSP does not attach to all yaml files
	root_dir = function(bufnr, on_dir)
		local parent = vim.fs.dirname(vim.api.nvim_buf_get_name(bufnr))
		if
			vim.endswith(parent, "/.github/workflows")
			or vim.endswith(parent, "/.forgejo/workflows")
			or vim.endswith(parent, "/.gitea/workflows")
		then
			on_dir(parent)
		end
	end,

	init_options = {
		-- Optional: provide a GitHub token and repo context for added functionality
		-- (e.g., repository-specific completions)
		sessionToken = get_github_token(),
		repos = get_repos_config(),
	},

	-- allow the lsp to register capabilities on demand
	capabilities = {
		workspace = {
			didChangeWorkspaceFolders = {
				dynamicRegistration = true,
			},
		},
	},

	-- given a file:// protocol path as built using the workspaceUri above,
	-- resolve path to disk path and provide filecontents when lsp requests this
	-- action https://github.com/actions/languageservices/blob/main/languageserver/src/request.ts#L2
	-- taken from https://github.com/neovim/nvim-lspconfig/blob/75e49cfa588a89ca667d767c0afef3ceac205faa/lsp/gh_actions_ls.lua#L33-L48
	handlers = {
		["actions/readFile"] = function(_, result)
			if type(result.path) ~= "string" then
				return nil, nil
			end
			local file_path = vim.uri_to_fname(result.path)
			if vim.fn.filereadable(file_path) == 1 then
				local fd = assert(io.open(file_path, "r"))
				local text = fd:read("*a")
				fd:close()

				return text, nil
			end

			return nil, nil
		end,
	},
}
