--[[
 _____ _ _      _
|  ___(_) | ___| |_ _   _ _ __   ___
| |_  | | |/ _ \ __| | | | '_ \ / _ \
|  _| | | |  __/ |_| |_| | |_) |  __/
|_|   |_|_|\___|\__|\__, | .__/ \___|
                    |___/|_|
--]]

--- @param path string the path which may be in a helm chart
--- @return boolean
local function in_helm_chart(path)
	return vim.fs.root(path, "Chart.yaml") ~= nil
end

local function in_tofu(path)
	local root = vim.fs.root(path, function(name, _)
		return string.find(name, "%.tofu$") ~= nil
	end)

	return root ~= nil
end

local state = vim.uv.os_getenv("XDG_STATE_HOME")

vim.filetype.add({
	filename = {
		["action.yml"] = "yaml.gh-action",
		["action.yaml"] = "yaml.gh-action",

		["compose.yaml"] = "yaml.docker-compose",
		["compose.yml"] = "yaml.docker-compose",

		["docker-compose.yaml"] = "yaml.docker-compose",
		["docker-compose.yml"] = "yaml.docker-compose",

		["fish_history"] = "yaml",

		["kustomization.yaml"] = "yaml.kustomization",
		["kustomization.yml"] = "yaml.kustomization",
		["Kustomization"] = "yaml.kustomization",

		["librewolf.overrides.cfg"] = "javascript",

		[".regal.yml"] = "yaml.regal",
		[".regal.yaml"] = "yaml.regal",

		["terragrunt.hcl"] = "hcl.terragrunt",
		["terragrunt.stack.hcl"] = "hcl.terragrunt-stack",

		["wireplumber.conf"] = "spajson",

		[".lefthook-local.yaml"] = "yaml.lefthook",
		[".lefthook-local.yml"] = "yaml.lefthook",
		[".lefthook.yaml"] = "yaml.lefthook",
		[".lefthook.yml"] = "yaml.lefthook",
		["lefthook-local.yaml"] = "yaml.lefthook",
		["lefthook-local.yml"] = "yaml.lefthook",
		["lefthook.yaml"] = "yaml.lefthook",
		["lefthook.yml"] = "yaml.lefthook",

		[state .. "/wireplumber/default-nodes"] = "dosini",
		[state .. "/wireplumber/default-profile"] = "dosini",
		[state .. "/wireplumber/default-routes"] = "dosini",
		[state .. "/wireplumber/stream-properties"] = "dosini",
	},

	extension = {
		conf = "dosini",
		dockerignore = "dockerignore",
		env = "env",
		envrc = "sh",
		helmignore = "helmignore",
		tf = "terraform",
		tmpl = "gotmpl",
		tofu = "opentofu",
		tofuvars = "opentofu-vars",
		tpl = "gotmpl",
		xkb = "xkb",
		yaml = "yaml",
		yml = "yaml",

		scm = function(_, bufnr)
			local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, true)[1]
			if string.find(line, "^#!.*[Gg]uile") then
				return "scheme.guile"
			end

			local detected
			vim.api.nvim_buf_call(bufnr, function()
				detected = vim.fn.search([[\v(; .*)@<!<(define-module|use-modules|ice-9)>]], "cnw") ~= 0
			end)

			if detected then
				return "scheme.guile"
			end

			local alt_buf = vim.fn.bufnr("#")
			if alt_buf == -1 then
				return "scheme"
			end

			local alt_buf_ft = vim.api.nvim_get_option_value("filetype", { buf = vim.fn.bufnr("#") })
			if string.find(alt_buf_ft, "^scheme") then
				return alt_buf_ft
			end

			return "scheme"
		end,

		tfvars = function(path)
			if in_tofu(path) then
				return "opentofu-vars"
			end

			return "terraform-vars"
		end,
	},

	pattern = {
		[".*/[^/]*%.gitlab%-ci%.ya?ml"] = "yaml.gitlab-ci",
		[".*/%.github/workflows/.*%.ya?ml"] = "yaml.gh-wf",

		[".*/[Tt]askfile[^/]*%.ya?ml"] = "yaml.taskfile",

		[".*/%.regal/config%.ya?ml"] = "yaml.regal",
		[".*/templates/.*%.tm?pl"] = function(path)
			if in_helm_chart(path) then
				return "helm"
			end
		end,

		[".*/[^/]*values.ya?ml"] = {
			function(path)
				if in_helm_chart(path) then
					return "yaml.helm-values"
				end
			end,

			-- takes priority over *.yaml resolution, but not over templates/*.yaml
			{ priority = 1 },
		},

		[".*/templates/.*%.ya?ml"] = {
			function(path)
				if in_helm_chart(path) then
					return "helm"
				end
			end,

			-- takes priority over values.yaml resolution
			{ priority = 2 },
		},

		[".*/.*%.ya?ml"] = function(path)
			local parent = vim.fs.dirname(vim.fs.dirname(path))
			if in_helm_chart(parent) then
				return "helm"
			end
		end,
	},
})
