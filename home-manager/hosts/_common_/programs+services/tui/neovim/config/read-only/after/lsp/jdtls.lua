local JAVA_RUNTIMES = vim.uv.os_getenv("JAVA_RUNTIMES")

-- e.g. JavaSE-18', 'JavaSE-19', 'JavaSE-20', 'JavaSE-21', 'JavaSE-22'
-- see: https://github.com/eclipse-jdtls/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request

local runtimes
if JAVA_RUNTIMES ~= nil then
	runtimes = {}
	JAVA_RUNTIMES:gsub("(%w+)=([^:]+):?", function(name, path)
		table.insert(runtimes, {
			name = name,
			path = path,
		})
	end)
end
local function get_jdtls_cache_dir()
	return vim.fn.stdpath("cache") .. "/jdtls"
end

local function get_jdtls_workspace_dir()
	return get_jdtls_cache_dir() .. "/workspace"
end

--- @type vim.lsp.Config
return {
	--- @param dispatchers? vim.lsp.rpc.Dispatchers
	--- @param config vim.lsp.ClientConfig
	cmd = function(dispatchers, config)
		local data_dir = get_jdtls_workspace_dir()
		if config.root_dir then
			data_dir = vim.fs.joinpath(data_dir, vim.fn.fnamemodify(config.root_dir, ":p:h:t"))
		end

		local config_cmd = {
			"jdtls",
			"-data",
			data_dir,
			"-Xmx8g",
		}

		local lombok_path = vim.fn.exepath("lombok.jar")
		if lombok_path ~= "" then
			table.insert(config_cmd, "-javaagent:" .. lombok_path)
		end

		return vim.lsp.rpc.start(config_cmd, dispatchers, {
			cwd = config.cmd_cwd,
			env = config.cmd_env,
			detached = config.detached,
		})
	end,

	init_options = {
		bundles = require("spring_boot").java_extensions(),
		extendedClientCapabilities = require("jdtls.capabilities"),
	},

	settings = {
		java = {
			configuration = {
				codeGeneration = {
					generateComments = true,
					useBlocks = true,
				},

				completion = {
					enabled = true,
					matchCase = "off",
				},

				runtimes = runtimes,

				telemetry = {
					enabled = false,
				},
			},
		},
	},
}
