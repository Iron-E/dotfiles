--- @class iron-e.plugins.Pack
local M = {
	--- @type { [string]: fun() }
	build_instructions = {},
}

local group = vim.api.nvim_create_augroup("config.pack", { clear = true })

------------------------
--- BUILDING PLUGINS ---
------------------------

vim.api.nvim_create_user_command("PackBuild", function(args)
	local plugin
	if args.args ~= "" then
		plugin = args.args
	end

	local build_instruction = M.build_instructions[plugin]
	if build_instruction == nil then
		return
	end

	if args.bang then
		vim.api.nvim_command("packadd! " .. plugin)
	end

	build_instruction()
end, {
	desc = "Run a build command for a plugin",
	bang = true,
	nargs = "?",
	complete = function()
		return vim.tbl_keys(M.build_instructions)
	end,
})

vim.api.nvim_create_autocmd("PackChanged", {
	desc = "Run build hooks for packages",
	group = group,
	callback = function(ev)
		if ev.data.kind == "delete" then
			return
		end

		vim.api.nvim_command("PackBuild! " .. ev.data.spec.name)
	end,
})

--------------------------
--- PLUGIN MAINTENANCE ---
--------------------------

--- @return string[]
local function get_package_names()
	local plugins = vim.pack.get(nil, { info = false })

	return vim.iter(ipairs(plugins))
		:map(function(_, plugin)
			return plugin.spec.name
		end)
		:totable()
end

vim.api.nvim_create_user_command("PackClean", function()
	local plugins = vim.pack.get(nil, { info = false })

	local active_plugin_names = {}
	for _, plugin in ipairs(plugins) do
		if not plugin.active then
			table.insert(active_plugin_names, plugin.spec.name)
		end
	end

	vim.pack.del(active_plugin_names)
end, {
	desc = "Clean inactive packages",
})

vim.api.nvim_create_user_command("PackRestore", function(args)
	local fargs
	if #args.fargs > 0 then
		fargs = args.fargs
	end

	vim.pack.update(fargs, { target = "lockfile" })
end, {
	desc = "Restore a package to its lockfile version",
	nargs = "?",
	complete = get_package_names,
})

vim.api.nvim_create_user_command("PackUpdate", function(args)
	local fargs
	if #args.fargs > 0 then
		fargs = args.fargs
	end

	vim.pack.update(fargs)
end, {
	desc = "Clean inactive packages",
	nargs = "?",
	complete = get_package_names,
})

-------------------

return M
