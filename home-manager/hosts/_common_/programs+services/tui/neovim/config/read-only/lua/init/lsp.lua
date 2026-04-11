------------
-- config --
------------

do -- PERF: disable LSP watcher. Too slow on Linux
	local watchfiles = require("vim.lsp._watchfiles")
	watchfiles._watchfunc = function()
		return function() end
	end
end

-- Do not log the LSP
vim.lsp.log.set_level(vim.lsp.log_levels.OFF)

--------------
-- commands --
--------------

vim.api.nvim_create_user_command("LspDetach", function(args)
	local buf = vim.api.nvim_get_current_buf()
	local clients = vim.lsp.get_clients({ buf = buf })

	local margs
	if #args.fargs == 0 then
		margs = setmetatable({}, {
			__index = function()
				return true
			end,
		})
	else
		margs = vim.iter(ipairs(args.fargs)):fold({}, function(acc, _, arg)
			acc[arg] = true
			return acc
		end)
	end

	for _, client in ipairs(clients) do
		if margs[client.name] == true then
			vim.lsp.buf_detach_client(buf, client.id)
		end
	end
end, {
	nargs = "*",
	complete = function()
		local clients = vim.lsp.get_clients({ buf = 0 })
		return vim.iter(ipairs(clients))
			:map(function(_, client)
				return client.name
			end)
			:totable()
	end,
})

--------------
-- autocmds --
--------------

local group = vim.api.nvim_create_augroup("config.lsp", { clear = true })

vim.lsp.linked_editing_range.enable(true)
vim.lsp.codelens.enable(false) -- TODO: re-enable when appearance is configurable

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Enable on_type_formatting for certain clients",
	group = group,
	callback = function(ev)
		local client_id = ev.data.client_id

		local client = vim.lsp.get_client_by_id(ev.data.client_id)
		if client == nil or client.name == "lua_ls" then
			return
		end

		vim.lsp.on_type_formatting.enable(true, { client_id = client_id })
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Use LSP foldexpr",
	group = group,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client == nil or not client:supports_method("textDocument/foldingRange") then
			return
		end

		vim.api.nvim_set_option_value("foldexpr", "v:lua.vim.lsp.foldexpr()", { scope = "local" })
	end,
})

-------------
-- keymaps --
-------------

vim.api.nvim_del_keymap("n", "gra")
vim.api.nvim_del_keymap("n", "gri")
vim.api.nvim_del_keymap("n", "grn")
vim.api.nvim_del_keymap("n", "grr")
vim.api.nvim_del_keymap("n", "grt")
vim.api.nvim_del_keymap("n", "grx")
vim.api.nvim_del_keymap("x", "gra")

vim.api.nvim_create_autocmd("LspAttach", {
	desc = "Setup keymaps",
	group = group,
	callback = function(event)
		local bufnr = event.buf
		local opts = { buffer = bufnr }

		vim.api.nvim_buf_set_keymap(bufnr, "n", "gA", "", { callback = vim.lsp.buf.rename })
		vim.api.nvim_buf_set_keymap(bufnr, "n", "gL", "", { callback = vim.lsp.codelens.run })
		vim.keymap.set({ "i", "n" }, "<C-h>", vim.lsp.buf.signature_help, opts)

		do
			local modes = { "n", "x" }
			vim.keymap.set(modes, "gX", vim.lsp.buf.code_action, opts)
		end

		local client = vim.lsp.get_client_by_id(event.data.client_id)
		if client == nil then
			return
		end

		if client:supports_method("textDocument/inlayHint") then
			local conceallevel = vim.api.nvim_get_option_value("conceallevel", { scope = "local" })

			local filter = { bufnr = bufnr }
			vim.lsp.inlay_hint.enable(conceallevel > 0, filter)
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>c", "", {
				desc = "Toggle inlay hints and text conceal",
				callback = function()
					local is_enabled = vim.lsp.inlay_hint.is_enabled(filter)
					vim.lsp.inlay_hint.enable(not is_enabled, filter)
					vim.api.nvim_command("ToggleWinConcealLevel")
				end,
			})
		end

		if client:supports_method("textDocument/codeLens") then
			vim.api.nvim_buf_set_keymap(bufnr, "n", "<Leader>L", "", {
				desc = "Toggle code lenses",
				callback = function()
					--- @type vim.lsp.capability.enable.Filter
					local filter = { bufnr = bufnr }
					vim.lsp.codelens.enable(not vim.lsp.codelens.is_enabled(filter), filter)
				end,
			})
		end
	end,
})

------------
-- enable --
------------

vim.lsp.enable({
	"basedpyright",
	"bashls",
	"buf_ls",
	"denols",
	"docker_language_server",
	"emmet_language_server",
	"gopls",
	"helm_ls",
	"html",
	"jdtls",
	"jsonls",
	"jsonnet_ls",
	"lua_ls",
	"marksman",
	"nixd",
	"rust_analyzer",
	"sqls",
	"tailwindcss",
	"terraformls",
	"tinymist",
	"tofu_ls",
	"ts_ls",
	"yamlls",
})
