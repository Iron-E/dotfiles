local vertical_split = {
	aboveleft = "left",
	topleft = "left",
	belowright = "right",
	botright = "right",
}

local horizontal_split = {
	aboveleft = "above",
	topleft = "above",
	belowright = "below",
	botright = "below",
}

---@param vertical vim.api.keyset.parse_cmd.mods
---@return "above"|"left"|"right"|"below"
local function get_split(mods)
	if mods.vertical then
		local resolved = vertical_split[mods.split]
		if resolved ~= nil then
			return resolved
		elseif vim.api.nvim_get_option_value("splitright", {}) then
			return "right"
		else
			return "left"
		end
	end

	local resolved = horizontal_split[mods.split]
	if resolved ~= nil then
		return resolved
	elseif vim.api.nvim_get_option_value("splitbelow", {}) then
		return "below"
	else
		return "above"
	end
end

--- @async
--- @param title? string
--- @param mods? vim.api.keyset.parse_cmd.mods
local function create(title, mods)
	if title == nil or title == "" then
		vim.ui.input(
			{ prompt = "Title" },
			vim.schedule_wrap(function(text)
				if type(text) == "string" and #text ~= 0 then
					return create(text, mods)
				end
			end)
		)

		return
	end

	if mods == nil then
		--- @diagnostic disable-next-line missing-fields
		mods = {}
	end

	local split = get_split(mods)

	local current_buf = vim.api.nvim_get_current_buf()
	local current_file_path = vim.api.nvim_buf_get_name(current_buf)

	local current_dir_name = vim.fs.dirname(current_file_path)

	local new_file_name = title:lower():gsub("%s", "-") .. ".md"
	local new_file_path = vim.fs.joinpath(current_dir_name, new_file_name)

	local new_buf = vim.api.nvim_create_buf(true, false)
	vim.api.nvim_buf_set_name(new_buf, new_file_path)
	vim.api.nvim_buf_set_lines(new_buf, 0, -1, true, { "# " .. title, "", "" })
	vim.api.nvim_set_option_value("filetype", "markdown", { buf = new_buf })

	local win = vim.api.nvim_open_win(new_buf, true, {
		split = split,
		vertical = mods.vertical,
	})

	vim.api.nvim_win_set_cursor(win, { 3, 0 })
end

vim.api.nvim_buf_create_user_command(0, "New", function(args)
	--- @cast args vim.api.keyset.create_user_command.command_args

	create(args.args, args.smods)
end, {
	desc = "Create a new markdown buffer with the given header.",
	nargs = "?",
})
