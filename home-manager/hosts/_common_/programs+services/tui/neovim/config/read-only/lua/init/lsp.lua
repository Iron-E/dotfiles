------------
-- config --
------------

do -- PERF: disable LSP watcher. Too slow on Linux
	local watchfiles = require 'vim.lsp._watchfiles'
	watchfiles._watchfunc = function() return function() end end
end

-- Do not log the LSP
vim.lsp.set_log_level(vim.lsp.log_levels.OFF)

--------------
-- autocmds --
--------------

vim.api.nvim_create_autocmd({ 'BufEnter', 'CursorHold', 'InsertLeave' }, {
	desc = 'Refresh codelens',
	group = 'config',
	callback = function()
		vim.lsp.codelens.refresh { bufnr = 0 }
	end,
})

vim.api.nvim_create_autocmd('LspAttach', {
	desc = 'Use LSP foldexpr',
	group = 'config',
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil or not client:supports_method 'textDocument/foldingRange' then
			return
		end

		vim.api.nvim_set_option_value('foldexpr', 'v:lua.vim.lsp.foldexpr()', { scope = 'local' })
	end,
})

-------------
-- keymaps --
-------------

vim.api.nvim_del_keymap('n', 'gri')
vim.api.nvim_del_keymap('n', 'grr')
vim.api.nvim_del_keymap('x', 'gra')
vim.api.nvim_del_keymap('n', 'gra')
vim.api.nvim_del_keymap('n', 'grn')

vim.api.nvim_create_autocmd('LspAttach', {
	group = 'config',
	callback = function(event)
		local bufnr = event.buf
		local opts = { buffer = bufnr }

		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gA', '', { callback = vim.lsp.buf.rename })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '', { callback = vim.lsp.buf.declaration })
		vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gL', '', { callback = vim.lsp.codelens.run })
		vim.keymap.set({ 'i', 'n' }, '<C-h>', vim.lsp.buf.signature_help, opts)

		do
			local modes = { 'n', 'x' }
			vim.keymap.set(modes, 'gX', vim.lsp.buf.code_action, opts)
		end

		if vim.lsp.get_client_by_id(event.data.client_id).server_capabilities.inlayHintProvider then
			local conceallevel = vim.api.nvim_get_option_value('conceallevel', { scope = 'local' })

			local filter = { bufnr = bufnr }
			vim.lsp.inlay_hint.enable(conceallevel > 0, filter)
			vim.api.nvim_buf_set_keymap(bufnr, 'n', '<Leader>c', '', { callback = function()
					local is_enabled = vim.lsp.inlay_hint.is_enabled(filter)
					vim.lsp.inlay_hint.enable(not is_enabled, filter)
					vim.api.nvim_command 'ToggleWinConcealLevel'
			end })
		end
	end,
})

------------
-- enable --
------------

vim.lsp.enable {
	'bashls',
	'buf_ls',
	'denols',
	'docker_language_server',
	'emmet_language_server',
	'gopls',
	'helm_ls',
	'html',
	'jdtls',
	'jsonls',
	'jsonnet_ls',
	'lua_ls',
	'nixd',
	'pyright',
	'rust_analyzer',
	'sqls',
	'tailwindcss',
	'terraformls',
	'tinymist',
	'tofu_ls',
	'ts_ls',
	'yamlls',
}
