--- @class iron-e.plugins.pack.Loader
local M = {
	local_pack_path = vim.fn.stdpath("data") .. "/site/pack/local/opt/",

	--- The plugins which were queued to load.
	--- @type string[]
	plugin_load_queue = {},
}

local group = vim.api.nvim_create_augroup("config.pack.loader", { clear = true })

--- @param spec string|vim.pack.Spec
--- @return string
function M.plugin_name_from_spec(spec)
	--- sometimes, the spec name has to be derived from a url
	local spec_src

	if type(spec) == "string" then
		spec_src = spec
	elseif spec.name ~= nil then
		return spec.name --- @type string
	else
		spec_src = spec.src
	end

	return vim.fs.basename(vim.fs.normalize(spec_src))
end

-- SEE: https://stackoverflow.com/questions/15429236/how-to-check-if-a-module-exists-in-lua
--- @param name string
--- @return boolean
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

--- initialized lazily
--- @type nil|{ [string]?: true }
local local_plugins = nil

--- @return { [string]?: true }
function M.list_local_plugins()
	if local_plugins == nil then
		local_plugins = {}

		-- vim.fs.dir checks if the dir exists
		for basename, kind in vim.fs.dir(M.local_pack_path, { follow = true }) do
			if kind == "directory" or kind == "link" then
				local_plugins[basename] = true
			end
		end
	end

	return local_plugins
end

--- remove extraneous suffixes and prefixes from plugin names
--- @param plugin_name string
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
--- @param plugin_name string
function M.config_plugin(plugin_name)
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
--- @param plugin_name string
function M.packadd(plugin_name)
	vim.cmd.packadd({
		args = { plugin_name },
		bang = vim.v.vim_did_init == 0,
	})
end

--- load a plugin.
--- @param plugin_name string
function M.load_plugin(plugin_name)
	M.packadd(plugin_name)
	M.config_plugin(plugin_name)
end

--- @param plugin_name string
--- @param event string|string[]
--- @param pattern? string|string[]
function M.load_plugin_on(plugin_name, event, pattern)
	vim.api.nvim_create_autocmd(event, {
		desc = "Load " .. plugin_name,
		group = group,
		pattern = pattern,
		once = true,
		callback = function()
			M.load_plugin(plugin_name)
			return true
		end,
	})
end

--- load a plugin.
--- @param plugin_name string
function M.enqueue_plugin_load(plugin_name)
	table.insert(M.plugin_load_queue, plugin_name)
end

--- Loads all queued plugins in a non-blocking way.
function M.load_queued_plugins()
	coroutine.resume(coroutine.create(function()
		local co = coroutine.running()

		for _, plugin_name in ipairs(M.plugin_load_queue) do
			vim.schedule(function()
				M.load_plugin(plugin_name)
				coroutine.resume(co)
			end)

			coroutine.yield()
		end

		-- free the queue
		M.plugin_load_queue = {}
	end))
end

return M
