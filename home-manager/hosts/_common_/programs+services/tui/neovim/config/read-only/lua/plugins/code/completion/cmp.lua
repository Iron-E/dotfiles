return {{ 'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies =
	{
		'hrsh7th/cmp-path',
		'hrsh7th/cmp-buffer',
		'hrsh7th/cmp-nvim-lsp',
		'hrsh7th/cmp-nvim-lua',
		'kdheepak/cmp-latex-symbols',
		{'kristijanhusak/vim-dadbod-completion', dependencies = 'tpope/vim-dadbod'},
		{'saadparwaiz1/cmp_luasnip',
			dependencies = {
				'L3MON4D3/LuaSnip',
				dependencies = 'rafamadriz/friendly-snippets',
				config = function()
					local luasnip = require 'luasnip'
					luasnip.setup { store_selection_keys = '<Tab>' }
					luasnip.log.set_loglevel('error') -- only log errors

					-- lazy load snippets
					local from_vscode = require 'luasnip.loaders.from_vscode'
					from_vscode.lazy_load { paths = vim.fn.stdpath('config') .. '/snippets' }
					from_vscode.lazy_load()
				end,
			},
		},
	},
	opts = function(_, o)
		local SOURCES =
		{
			buffer = '',
			latex_symbols = '󱔁',
			nvim_lsp = '',
			nvim_lua = '󰢱',
			path = '',
			luasnip = '',
			spell = '󰓆',
			['vim-dadbod-completion'] = '',
		}

		o.formatting = { format = function(entry, vim_item)
			vim_item.menu = SOURCES[entry.source.name]
			return vim_item
		end }

		o.window =
		{
			completion = { border = 'rounded', winhighlight = 'CursorLine:PmenuSel,Search:None' },
			documentation = { border = 'rounded', winhighlight = '' },
		}
	end,
	config = function(_, o)
		--- @return boolean # `true` if the cursor is on a word
		local function cursor_on_word()
			local col = vim.api.nvim_win_get_cursor(0)[2]
			return col ~= 0 and vim.api.nvim_get_current_line():sub(col, col):find '%s' == nil
		end

		local cmp = require 'cmp'
		local kind = require('cmp.types').lsp.CompletionItemKind --- @type lsp.CompletionItemKind
		local luasnip = require 'luasnip'

		local sources = {
			buffer = { name = 'buffer' },
			dadbod = { name = 'vim-dadbod-completion' },

			latex_symbols = {
				name = 'latex_symbols',
				max_item_count = 10,
			},

			luasnip = {
				name = 'luasnip',
				max_item_count = 10,
			},

			nvim_lsp = {
				name = 'nvim_lsp',
				entry_filter = function(entry) return kind[entry:get_kind()] ~= 'Text' end,
			},

			nvim_lua = { name = 'nvim_lua' },
			path = { name = 'path' },
		}

		cmp.setup(
		{
			formatting = o.formatting,
			snippet =  { expand = function(args) luasnip.lsp_expand(args.body) end },
			window = o.window,

			mapping =
			{
				['<C-b>'] = cmp.mapping.scroll_docs(-20),
				['<C-f>'] = cmp.mapping.scroll_docs(20),
				['<C-Space>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Insert, select = true },

				['<C-c>'] = cmp.mapping.complete {
					config = {
						source = cmp.config.sources(
							{ sources.nvim_lsp },
							{ sources.nvim_lua, sources.dadbod },
							{ sources.path },
							{ sources.buffer },
							{ sources.latex_symbols }
						),
					},
				},

				--- @param fallback fun()
				['<C-n>'] = cmp.mapping(function(fallback)
					if luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 'n', 's' }),

				--- @param fallback fun()
				['<C-p>'] = cmp.mapping(function(fallback)
					if luasnip.jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 'n', 's' }),

				--- @param fallback fun()
				['<Tab>'] = cmp.mapping(function(fallback)
					if not cmp.select_next_item() then
						if cursor_on_word() then
							cmp.complete()
						else
							fallback()
						end
					end
				end),

				--- @param fallback fun()
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if not cmp.select_prev_item() then
						if cursor_on_word() then
							cmp.complete()
						else
							fallback()
						end
					end
				end),
			},

			sources = cmp.config.sources(
				{ sources.luasnip, sources.nvim_lsp },
				{ sources.nvim_lua, sources.dadbod },
				{ sources.path },
				{ sources.buffer },
				{ sources.latex_symbols }
			),
		})
	end,
}}
