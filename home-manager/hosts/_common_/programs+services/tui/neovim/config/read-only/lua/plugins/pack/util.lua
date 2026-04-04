--- @class iron-e.plugins.pack.Util
local M = {
	--- The plugins which were queued to load.
	--- @type vim.pack.PlugData[]
	plugin_load_queue = {},
}

local group = vim.api.nvim_create_augroup("config.pack.util", { clear = true })

-- SEE: https://stackoverflow.com/questions/15429236/how-to-check-if-a-module-exists-in-lua
function M.module_exists(name)
	if package.loaded[name] then
		return true
	end

	for _, searcher in ipairs(package.loaders) do
		local loader = searcher(name)
		if type(loader) == "function" then
			package.preload[name] = loader
			return true
		end
	end

	return false
end

--- remove extraneous suffixes and prefixes from plugin names
--- @param plugin_name
--- @return string
function M.clean_plugin_name(plugin_name)
	if plugin_name:sub(1, 5) == "nvim-" then
		plugin_name = plugin_name:sub(6)
	elseif plugin_name:sub(1, 5) == "vim-" then
		plugin_name = plugin_name:sub(5)
	end

	local last_four_suffix = plugin_name:sub(-4, -1)
	if last_four_suffix == "-lua" or last_four_suffix == ".vim" then
		plugin_name = plugin_name:sub(1, -5)
	elseif plugin_name:sub(-5, -1) == ".nvim" then
		plugin_name = plugin_name:sub(1, -6)
	end

	return plugin_name
end

--- configure a loaded plugin
--- @param plugin vim.pack.PlugData
function M.config_plugin(plugin)
	local plugin_name = plugin.spec.name

	local config_module = M.clean_plugin_name(plugin_name)

	config_module = "plugins.pack." .. config_module
	if not M.module_exists(config_module) then
		return
	end

	local success, result = xpcall(function()
		require(config_module)
	end, debug.traceback)

	if success ~= true then
		vim.notify(
			vim.inspect({
				msg = "Failed to load plugin",
				plugin = plugin_name,
				config_module = config_module,
				stacktrace = result,
			}),
			vim.log.levels.ERROR
		)
	end
end

--- make a plugin configurable
--- @param plugin vim.pack.PlugData
function M.packadd(plugin)
	vim.cmd.packadd({
		args = { plugin.spec.name },
		bang = vim.v.vim_did_init == 0,
	})
end

--- load a plugin.
--- @param plugin vim.pack.PlugData
function M.load_plugin(plugin)
	M.packadd(plugin)
	M.config_plugin(plugin)
end

--- @param plugin vim.pack.PlugData
--- @param event string|string[]
--- @param pattern? string|string[]
function M.load_plugin_on(plugin, event, pattern)
	vim.api.nvim_create_autocmd(event, {
		desc = "Load " .. plugin.spec.name,
		group = group,
		pattern = pattern,
		once = true,
		callback = function()
			M.load_plugin(plugin)
			return true
		end,
	})
end

--- load a plugin.
--- @param plugin vim.pack.PlugData
function M.enqueue_plugin_load(plugin)
	table.insert(M.plugin_load_queue, plugin)
end

--- Loads all queued plugins in a non-blocking way.
function M.load_queued_plugins()
	coroutine.resume(coroutine.create(function()
		local co = coroutine.running()

		for _, plugin in ipairs(M.plugin_load_queue) do
			vim.schedule(function()
				M.load_plugin(plugin)
				coroutine.resume(co)
			end)

			coroutine.yield()
		end

		-- free the queue
		M.plugin_load_queue = {}
	end))
end

return M
