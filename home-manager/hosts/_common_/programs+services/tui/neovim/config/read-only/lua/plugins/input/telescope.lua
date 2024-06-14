return {
	{
		'nvim-telescope/telescope.nvim',
		cmd = 'Telescope',
		config = function(_, o)
			local telescope = require 'telescope'
			telescope.setup(o)
			telescope.load_extension 'fzf'
		end,
		dependencies = { {
			'nvim-telescope/telescope-fzf-native.nvim',
			build =
			'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
		} },
		init = function()
			vim.api.nvim_create_autocmd('LspAttach', {
				callback = function(event)
					local bufnr = event.buf
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<Cmd>Telescope lsp_definitions<CR>', {})
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gI', '<Cmd>Telescope lsp_implementations<CR>', {})
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<Cmd>Telescope lsp_references<CR>', {})
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gw', '<Cmd>Telescope lsp_document_symbols<CR>', {})
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gW', '<Cmd>Telescope lsp_workspace_symbols<CR>', {})
					vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gy', '<Cmd>Telescope lsp_type_definitions<CR>', {})
				end,
				group = 'config',
			})
		end,
		keys =
		{
			{ '<A-b>',     '<Cmd>Telescope buffers<CR>',       desc = 'Fuzzy find buffer',              mode = 'n' },
			{ '<A-f>',     '<Cmd>Telescope find_files<CR>',    desc = 'Fuzzy find file',                mode = 'n' },
			{ '<C-b>',     '<C-w>s<A-b>',                      desc = 'Fuzzy find buffer in new split', mode = 'n', remap = true },
			{ '<C-f>',     '<C-w>s<A-f>',                      desc = 'Fuzzy find file in new split',   mode = 'n', remap = true },
			{ '<Leader>F', '<Cmd>Telescope resume<CR>',        desc = 'Resume last telescope search',   mode = 'n' },
			{ '<Leader>f', '<Cmd>Telescope<CR>',               desc = 'Fuzzy find telescope pickers',   mode = 'n' },
			{ '<Leader>g', '<Cmd>Telescope live_grep<CR>',     desc = 'Fuzzy find telescope live grep', mode = 'n' },
			{ 'z=',        '<Cmd>Telescope spell_suggest<CR>', desc = 'Fuzzy find spelling suggestion', mode = 'n' },
		},
		opts = function(_, o)
			local previewers = require 'telescope.previewers'
			local cursor_theme = require('telescope.themes').get_cursor {
				layout_config = { height = 0.5, width = 0.9 },
			}

			local cursor_theme_no_jump = vim.deepcopy(cursor_theme)
			cursor_theme_no_jump.jump_type = 'never'

			o.defaults =
			{
				file_previewer = previewers.cat.new,
				grep_previewer = previewers.vimgrep.new,
				history = false,
				qflist_previewer = previewers.qflist.new,

				layout_config =
				{
					center = { prompt_position = 'bottom' },
					cursor = { height = 0.5, width = 0.9 },
					horizontal = { height = 0.95, width = 0.9 },
					vertical = { height = 0.95, width = 0.9 },
				},

				layout_strategy = 'flex',
				multi_icon = '󰄵 ',
				prompt_prefix = ' ',
				selection_caret = ' ',
			}

			o.extensions =
			{
				fzf = { fuzzy = true, override_file_sorter = true, override_generic_sorter = true },
				["ui-select"] = { cursor_theme },
			}

			o.pickers =
			{
				builtin = { include_extensions = true },
				lsp_definitions = cursor_theme,
				lsp_document_symbols = cursor_theme_no_jump,
				lsp_implementations = cursor_theme,
				lsp_references = cursor_theme_no_jump,
				lsp_workspace_symbols = cursor_theme_no_jump,
				spell_suggest = cursor_theme,
			}
		end,
	},

	{
		'dimaportenko/telescope-simulators.nvim',
		dependencies = 'telescope.nvim',
		lazy = true,
		main = 'simulators',
		opts = function(_, o)
			o.android_emulator = true
			o.apple_simulator = false
		end,
	},

	{
		'debugloop/telescope-undo.nvim',
		config = function() require('telescope').load_extension 'undo' end,
		dependencies = 'telescope.nvim',
		keys = { { '<A-w>u', '<Cmd>Telescope undo<CR>', desc = 'Telescope undo', mode = 'n' } },
	},

	{
		'nvim-telescope/telescope-ui-select.nvim',
		dependencies = 'telescope.nvim',
		lazy = true,
		init = function()
			--- Lazy loads telescope on first run
			--- @diagnostic disable-next-line:duplicate-set-field
			function vim.ui.select(...)
				require('telescope').load_extension 'ui-select'
				vim.ui.select(...)
			end
		end,
	},
}
