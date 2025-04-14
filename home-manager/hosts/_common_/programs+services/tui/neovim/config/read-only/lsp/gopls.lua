--- @type vim.lsp.Config
return {
	--- @param client vim.lsp.Client
	on_attach = function(client)
		if not client.server_capabilities.semanticTokensProvider then
			local semantic = vim.tbl_get(client, 'config', 'capabilities', 'textDocument', 'semanticTokens')
			if semantic then
				vim.notify_once(
					client.name .. ' supports semantic tokens but did not report it. Implementing workaround',
					vim.log.levels.INFO
				)

				client.server_capabilities.semanticTokensProvider =
				{
					full = true,
					legend = { tokenModifiers = semantic.tokenModifiers, tokenTypes = semantic.tokenTypes },
					range = true,
				}
			end
		end
	end,
	settings = {
		gopls = {
			semanticTokens = true,
		},
	}
}
