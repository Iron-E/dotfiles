--- @module 'blink.cmp'

return {{ 'Saghen/blink.cmp',
	version = '1.*',
	event = 'InsertEnter',
	build = 'nix run .#build-plugin',
	dependencies = {
		'echasnovski/mini.icons',
		'rafamadriz/friendly-snippets',
	},

	--- @param o blink.cmp.Config
	opts = function(_, o)
		local icons = require 'mini.icons'

		o.appearance = {
			use_nvim_cmp_as_default = true,
		}

		o.cmdline = {
			enabled = false,
		}

		o.completion = {
			documentation = {
				auto_show = true,
				auto_show_delay_ms = 500,
				window = {
					winhighlight = '',
				},
			},
			list = {
				selection = {
					preselect = true,
					auto_insert = false,
				},
			},
			menu = {
				draw = {
					columns = {
						{ 'label', 'label_description', gap = 1 },
						{ 'kind_icon', 'kind', 'source_name', gap = 1 },
					},
					components = {
						kind_icon = {
							text = function(ctx)
								local kind_icon, _, _ = icons.get('lsp', ctx.kind)
								return kind_icon
							end,

							highlight = function(ctx)
								local _, hl, _ = icons.get('lsp', ctx.kind)
								return hl
							end,
						},
					},
					treesitter = {
						'lsp',
					},
				},
				winhighlight = 'CursorLine:PmenuSel,Search:None',
			},
			trigger = {
				show_on_accept_on_trigger_character = false,
				show_on_insert_on_trigger_character = false,
			},
		}

		o.completion.menu.draw.components.kind = {
			highlight = o.completion.menu.draw.components.kind_icon.highlight,
		}

		o.fuzzy = {
			prebuilt_binaries = {
				download = false,
			},
			sorts = {
				--- Deprioritize emmet
				function(lhs, rhs)
					if lhs.client_name == nil or rhs.client_name == nil or lhs.client_name == rhs.client_name then
						return
					end

					return rhs.client_name == 'emmet_ls'
				end,
				'exact',
				'score',
				'sort_text',
			},
		}

		--- @return boolean # `true` if the cursor is on a word
		local function cursor_on_word()
			local col = vim.api.nvim_win_get_cursor(0)[2]
			return col ~= 0 and vim.api.nvim_get_current_line():sub(col, col):find '%s' == nil
		end

		--- @param cmp blink.cmp.API
		--- @return boolean|nil
		local function show_if_cursor_on_word(cmp)
			if cursor_on_word() then
				return cmp.show_and_insert()
			end
		end

		--- @param direction 'up'|'down'
		--- @return fun(cmp: blink.cmp.API): boolean|nil
		local function scroll_docs(direction)
			return function(cmp)
				return cmp['scroll_documentation_' .. direction](20)
			end
		end

		o.keymap = {
			preset = 'none',

			['<C-b>'] = { scroll_docs 'up', 'fallback' },
			['<C-f>'] = { scroll_docs 'down', 'fallback' },

			['<C-c>'] = { 'show_and_insert', 'fallback' },
			['<C-Space>'] = { 'accept', 'fallback' },

			['<C-n>'] = { 'snippet_forward', 'fallback' },
			['<C-p>'] = { 'snippet_backward', 'fallback' },

			['<Tab>'] = { 'select_next', show_if_cursor_on_word, 'fallback' },
			['<S-Tab>'] = { 'select_prev', show_if_cursor_on_word, 'fallback' },
		}

		o.snippets = {
			score_offset = -2,
		}

		o.sources = {
			default = {
				'lazydev',
				'lsp',
				'omni',
				'path',
				'snippets',
				'buffer',
			},
			providers = {
				buffer = {
					name = '',
				},
				dadbod = {
					name = "",
					module = 'vim_dadbod_completion.blink',
					enabled = function()
						return vim.api.nvim_get_option_value('filetype', { buf = 0 }) == 'sql'
					end,
				},
				lazydev = {
					name = '󰢱',
					module = 'lazydev.integrations.blink',
					score_offset = 100,
				},
				lsp = {
					name = '',
					async = true,
					fallbacks = {},
					score_offset = 2,
					transform_items = function(_, items)
						local new_items = {}
						for _, item in ipairs(items) do
							if item.kind ~= vim.lsp.protocol.CompletionItemKind.Text then
								table.insert(new_items, item)
							end
						end

						return new_items
					end,
				},
				latex_symbols = {
					name = '󱔁',
					module = 'blink.compat.source',
					max_items = 10,
				},
				path = {
					name = '',
				},
				snippets = {
					name = '',
					max_items = 10,
					score_offset = 0,
					opts = {
						search_paths = {
							vim.fn.stdpath('config') .. '/snippets',
						},
					},
				},
			},
		}

		--- @diagnostic disable param-type-mismatch
		o.sources.per_filetype = {
			sql = vim.list_extend({ 'dadbod' }, o.sources.default),
			latex = vim.list_extend(vim.deepcopy(o.sources.default), { 'latex_symbols' }),
		}
		--- @diagnostic enable

		o.sources.per_filetype.markdown = o.sources.per_filetype.latex
		o.sources.per_filetype.mysql = o.sources.per_filetype.sql
		o.sources.per_filetype.plsql = o.sources.per_filetype.sql
	end,
}}
