local Loader = require("plugins.pack.loader")

--- @class iron-e.plugins.Pack
local M = {
	--- @type { [string]: fun(plugin: vim.pack.PlugData) }
	build_instructions = {},
}

local group = vim.api.nvim_create_augroup("config.pack", { clear = true })

----------------------
--- LOCAL PLUGINS ----
----------------------

local old_add = vim.pack.add

--- vim.pack.add wrapper that adds support for local plugins
--- @param specs (string|vim.pack.Spec)[]
--- @param opts? vim.pack.keyset.add
--- @diagnostic disable-next-line:duplicate-set-field
vim.pack.add = function(specs, opts)
	opts = opts or {}

	local local_plugins = Loader.list_local_plugins()

	for i, spec in ipairs(specs) do
		local name = Loader.plugin_name_from_spec(spec)

		if not local_plugins[name] then
			goto continue
		end

		-- stop managing this plugin with vim.pack
		table.remove(specs, i)
		pcall(vim.pack.del, { name }, { confirm = true })

		if opts.load == nil then
			Loader.packadd(name)
		elseif type(opts.load) == "bool" then
			vim.cmd.packadd({ args = { name }, bang = not opts.load })
		else
			opts.load({
				path = Loader.local_pack_path .. name,
				spec = {
					name = name,
					src = spec.src,
					data = spec.data,
					version = spec.version,
				},
			})
		end

		::continue::
	end

	if #specs == 0 then
		return
	end

	old_add(specs, opts)
end

------------------------
--- BUILDING PLUGINS ---
------------------------

vim.api.nvim_create_user_command(
	"PackBuild",
	vim.schedule_wrap(function(args)
		--- @type nil|string[]
		local plugin_names
		if #args.fargs > 0 then
			plugin_names = vim.list.unique(args.fargs)
		end

		--- @type vim.pack.PlugData[]
		local plugins = vim.pack.get(plugin_names, { info = false })

		-- TODO: do I need a coroutine here?
		for _, plugin in ipairs(plugins) do
			local build_instruction = M.build_instructions[plugin.spec.name]
			if build_instruction == nil then
				goto continue
			end

			if args.bang then
				vim.api.nvim_command("packadd " .. plugin.spec.name)
			end

			vim.notify("Building " .. plugin.spec.name, vim.log.levels.INFO)
			build_instruction(plugin)

			::continue::
		end
	end),
	{
		desc = "Run a build command for a plugin",
		bang = true,
		nargs = "*",
		complete = function()
			return vim.tbl_keys(M.build_instructions)
		end,
	}
)

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
