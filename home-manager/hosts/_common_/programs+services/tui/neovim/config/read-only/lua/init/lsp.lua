do -- PERF: disable LSP watcher. Too slow on Linux
	local watchfiles = require 'vim.lsp._watchfiles'
	watchfiles._watchfunc = function() return function() end end
end

-- Do not log the LSP
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

-- enable all the LSPs I use
vim.lsp.enable {
	'ansiblels',
	'bashls',
	'buf_ls',
	'docker_compose_language_service',
	'dockerls',
	'emmet_language_server',
	'gopls',
	'harper_ls',
	'html',
	'jdtls',
	'jsonls',
	-- 'jsonnet_ls', TODO: enable after lspconfig migrates it
	'lua_ls',
	'nixd',
	'pyright',
	'rust_analyzer',
	'sqlls',
	-- 'tailwindcss', TODO: enable after lspconfig migrates it
	'terraformls',
	'tinymist',
	'ts_ls',
	'yamlls',
}
