--- @class iron-e.ftplugin.New
local New = {}

---@param mods vim.api.keyset.parse_cmd.mods
---@return "above"|"left"|"right"|"below"
local function get_split(mods)
	if mods.vertical then
		if mods.split == "aboveleft" or mods.split == "topleft" then
			return "left"
		elseif mods.split == "belowright" or mods.split == "botright" then
			return "right"
		elseif vim.api.nvim_get_option_value("splitright", {}) then
			return "right"
		end

		return "left"
	end

	if mods.split == "aboveleft" or mods.split == "topleft" then
		return "above"
	elseif mods.split == "belowright" or mods.split == "botright" then
		return "below"
	elseif vim.api.nvim_get_option_value("splitbelow", {}) then
		return "below"
	end

	return "above"
end

--- @param bufnr integer
--- @return string|nil title
local function get_title(bufnr)
	local lines = vim.api.nvim_buf_get_lines(bufnr, 0, 100, false)
	for _, line in ipairs(lines) do
		local match = line:match("^# (.*)$")
		if match ~= nil then
			return match
		end
	end
end

--- @async
--- @param from integer
--- @param title string
--- @param mods vim.api.keyset.parse_cmd.mods
local function create(from, title, mods)
	local from_file_path = vim.api.nvim_buf_get_name(from)

	local from_dir_name = vim.fs.dirname(from_file_path)

	local new_file_name = title:lower():gsub("%s", "-") .. ".md"
	local new_file_path = vim.fs.joinpath(from_dir_name, new_file_name)

	local new_buf = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_buf_set_name(new_buf, new_file_path)
	vim.api.nvim_buf_set_lines(new_buf, 0, -1, true, { "# " .. title, "", "" })
	vim.api.nvim_set_option_value("filetype", "markdown", { buf = new_buf })

	local split = get_split(mods)
	local win = vim.api.nvim_open_win(new_buf, true, {
		split = split,
		vertical = mods.vertical,
	})

	vim.api.nvim_win_set_cursor(win, { 3, 0 })
end

--- @param args vim.api.keyset.create_user_command.command_args
function New.user_command_cb(args)
	local current = vim.api.nvim_get_current_buf()

	if args.args == nil or args.args == "" then
		local default = get_title(current)

		vim.ui.input({ prompt = "Title", default = default }, function(text)
			if text == nil or #text == 0 then
				return
			end

			create(current, text, args.smods)
		end)

		return
	end

	create(current, args.args, args.smods)
end

return New
