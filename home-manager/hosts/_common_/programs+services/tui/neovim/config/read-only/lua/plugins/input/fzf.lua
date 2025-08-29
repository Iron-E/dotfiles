--- @module 'fzf-lua'
--- @module 'lazy'

--- @type LazySpec[]
return {{ 'ibhagwan/fzf-lua',
	dependencies = 'echasnovski/mini.icons',

	cmd = 'FzfLua',

	keys = {
		{ '<A-b>',     '<Cmd>FzfLua buffers<CR>',       mode = 'n' },
		{ '<A-f>',     '<Cmd>FzfLua files<CR>',         mode = 'n' },
		{ '<Leader>F', '<Cmd>FzfLua resume<CR>',        mode = 'n' },
		{ '<Leader>f', '<Cmd>FzfLua<CR>',               mode = 'n' },
		{ '<Leader>g', '<Cmd>FzfLua live_grep<CR>',     mode = 'n' },
		{ 'z=',        '<Cmd>FzfLua spell_suggest<CR>', mode = 'n' },
	},

	init = function()
		vim.api.nvim_create_autocmd('LspAttach', {
			callback = function(event)
				local bufnr = event.buf
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>FzfLua lsp_definitions<CR>', {})
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<Cmd>FzfLua lsp_implementations<CR>', {})
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>FzfLua lsp_references<CR>', {})
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gw', '<Cmd>FzfLua lsp_document_symbols<CR>', {})
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gW', '<Cmd>FzfLua lsp_live_workspace_symbols<CR>', {})
				vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<Cmd>FzfLua lsp_typedefs<CR>', {})
			end,
			group = 'config',
		})

		--- @diagnostic disable-next-line:duplicate-set-field
		vim.ui.select = function(...)
			vim.api.nvim_command('FzfLua register_ui_select winopts.width=0.33 winopts.height=0.33 winopts.relative=cursor winopts.row=1 winopts.col=3')
			vim.ui.select(...)
		end
	end,

	config = function(_, o)
		local fzf = require 'fzf-lua'
		local opts = o.new(fzf)
		fzf.setup(opts)
	end,

	opts = function(_, o)
		function o.new(fzf)
			local opts = {
				{ 'fzf-native', 'hide' },
			}

			opts.keymap = {
				builtin = {
					["<M-Esc>"] = "abort",
					["<F1>"]  = "toggle-help",
					["<F2>"]  = "toggle-fullscreen",
					-- Only valid with the 'builtin' previewer
					["<F3>"]  = "toggle-preview-wrap",
					["<F4>"]  = "toggle-preview",
					-- Rotate preview clockwise/counter-clockwise
					["<F5>"]  = "toggle-preview-ccw",
					["<F6>"]  = "toggle-preview-cw",
					-- `ts-ctx` binds require `nvim-treesitter-context`
					["<F7>"]  = "toggle-preview-ts-ctx",
					["<F8>"]  = "preview-ts-ctx-dec",
					["<F9>"]  = "preview-ts-ctx-inc",
					["<A-l>"] = "preview-reset",
					["<A-d>"] = "preview-page-down",
					["<A-u>"] = "preview-page-up",
					["<A-j>"] = "preview-down",
					["<A-k>"] = "preview-up",
				},

				-- Use FZF_DEFAULT_OPTS_FILE
				fzf = {},
			}

			opts.actions = {
				-- Pickers inheriting these actions:
				--   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
				--   tags, btags, args, buffers, tabs, lines, blines
				files = {
					["enter"]  = fzf.actions.file_edit_or_qf,
					["ctrl-s"] = fzf.actions.file_split,
					["ctrl-x"] = fzf.actions.file_vsplit,
					["ctrl-t"] = fzf.actions.file_tabedit,
					["alt-q"]  = fzf.actions.file_sel_to_qf,
					["alt-Q"]  = fzf.actions.file_sel_to_ll,
					["alt-i"]  = fzf.actions.toggle_ignore,
					["alt-h"]  = fzf.actions.toggle_hidden,
					["alt-f"]  = fzf.actions.toggle_follow,
				},
			}

			opts.fzf_opts = {
				['--keep-right'] = false,
			}

			opts.files = {
				fzf_opts = {
					['--keep-right'] = true,
				},
			}

			opts.grep = {
				RIPGREP_CONFIG_PATH = vim.uv.os_getenv 'RIPGREP_CONFIG_PATH'
			}

			return opts
		end
	end,
}}
