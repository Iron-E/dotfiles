--- @module 'blink.cmp'

return {
	{
		"Saghen/blink.cmp",
		version = "1.*",
		-- event = 'InsertEnter', WARN: cannot lazy load, or else language servers will not have the correct capabilities set
		build = "nix run .#build-plugin",
		dependencies = {
			"echasnovski/mini.icons",
			"rafamadriz/friendly-snippets",
		},

		--- @param o blink.cmp.Config
		opts = function(_, o)
			local icons = require("mini.icons")
			local completion_item_kind = vim.lsp.protocol.CompletionItemKind

			o.appearance = {
				use_nvim_cmp_as_default = true,
			}

			o.cmdline = {
				enabled = false,
			}

			--- @param ctx blink.cmp.Context
			--- @return boolean
			local function should_preselect(ctx)
				local length = ctx.bounds.length
				if length == 0 then -- there is no 'word' yet
					return true
				end

				local column = ctx.cursor[2]
				local offset = 1 -- the initial bounds length is 1, which would offset the start_col too far
				return column == ctx.bounds.start_col + length - offset -- at the end of the match
			end

			o.completion = {
				accept = {
					auto_brackets = {
						-- completing for existing function calls bugs out
						-- e.g. foo|(bar) turns into foo()(bar)
						enabled = false,
					},
				},
				documentation = {
					auto_show = true,
					auto_show_delay_ms = 500,
					window = {
						winhighlight = "",
					},
				},
				keyword = {
					range = "full",
				},
				list = {
					selection = {
						preselect = should_preselect,
						auto_insert = function(ctx)
							return not should_preselect(ctx)
						end,
					},
				},
				menu = {
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind", "source_name", gap = 1 },
						},
						components = {
							kind_icon = {
								text = function(ctx)
									local kind_icon, _, _ = icons.get("lsp", ctx.kind)
									return kind_icon
								end,

								highlight = function(ctx)
									local _, hl, _ = icons.get("lsp", ctx.kind)
									return hl
								end,
							},
						},
						treesitter = {
							"lsp",
						},
					},
					winhighlight = "CursorLine:PmenuSel,Search:None",
				},
				trigger = {
					show_on_accept_on_trigger_character = false,
					show_on_insert_on_trigger_character = false,
				},
			}

			o.completion.menu.draw.components.kind = {
				highlight = o.completion.menu.draw.components.kind_icon.highlight,
			}

			--- create a sorting function to deprioritize the given lsp
			---@param lsp string
			---@return blink.cmp.SortFunction
			local function deprioritize_lsp(lsp)
				return function(lhs, rhs)
					if -- one of the clients is the given lsp
						(lhs.client_name == lsp or rhs.client_name == lsp)
						-- but not both
						and lhs.client_name ~= rhs.client_name
					then
						return rhs.client_name == lsp
					end
				end
			end

			--- create a sorting function to deprioritize the given completion kind
			---@param kind lsp.CompletionItemKind
			---@return blink.cmp.SortFunction
			local function deprioritize_kind(kind)
				return function(lhs, rhs)
					if -- either the lhs or rhs is a keyword
						(lhs.kind == kind or rhs.kind == kind)
						-- and one is not a keyword
						and lhs.kind ~= rhs.kind
					then
						return rhs.kind == kind
					end
				end
			end

			--- create a sorting function to deprioritize the given completion kind
			---@param kind lsp.CompletionItemKind
			---@param source_id string
			---@return blink.cmp.SortFunction
			local function deprioritize_kind_from(source_id, kind)
				return function(lhs, rhs)
					if -- both the lhs and rhs are snippets
						(lhs.kind == rhs.kind and rhs.kind == kind)
						-- one of the sources is "snippets"
						and (lhs.source_id == source_id or rhs.source_id == source_id)
						-- but the sources are not the same
						and lhs.source_id ~= rhs.source_id
					then
						return rhs.source_id == source_id
					end
				end
			end

			o.fuzzy = {
				prebuilt_binaries = {
					download = false,
				},
				sorts = {
					deprioritize_lsp("emmet_ls"),
					"exact",
					deprioritize_kind(completion_item_kind.Keyword),
					"score",
					deprioritize_kind_from("snippets", completion_item_kind.Snippet),
					"sort_text",
				},
			}

			--- @param direction 'up'|'down'
			--- @return fun(cmp: blink.cmp.API): boolean|nil
			local function scroll_docs(direction)
				return function(cmp)
					return cmp["scroll_documentation_" .. direction](20)
				end
			end

			--- @type blink.cmp.Context
			--- @diagnostic disable-next-line missing-required-fields
			local default_ctx = {
				get_cursor = function()
					return vim.api.nvim_win_get_cursor(0)
				end,

				get_line = function(num)
					return vim.api.nvim_buf_get_lines(0, num, num + 1, false)[1]
				end,
			}

			--- @param cmp blink.cmp.API
			--- @return boolean|nil
			local function show_if_cursor_on_word(cmp)
				local ctx = cmp.get_context() or default_ctx
				if ctx.mode == "cmdline" then
					return cmp.show()
				end

				local cursor = ctx.get_cursor()
				local column = cursor[2]
				if column < 1 then
					return
				end

				local line = ctx.get_line(cursor[1] - 1)
				local char = line:sub(column, column)

				if char:find("%s") == nil then
					return cmp.show()
				end
			end

			o.keymap = {
				preset = "none",

				["<C-b>"] = { scroll_docs("up"), "fallback" },
				["<C-f>"] = { scroll_docs("down"), "fallback" },

				["<C-c>"] = { "show", "fallback" },
				["<C-e>"] = { "cancel", "fallback" },
				["<C-Space>"] = { "accept", "fallback" },

				["<C-n>"] = { "snippet_forward", "fallback" },
				["<C-p>"] = { "snippet_backward", "fallback" },

				["<Tab>"] = { "select_next", show_if_cursor_on_word, "fallback" },
				["<S-Tab>"] = { "select_prev", show_if_cursor_on_word, "fallback" },
			}

			o.snippets = {
				score_offset = -2,
			}

			o.sources = {
				default = { "lsp", "omni", "path", "snippets", "buffer" },
				providers = {
					buffer = {
						name = "",
					},
					cmdline = {
						name = "",
					},
					dadbod = {
						name = "",
						module = "vim_dadbod_completion.blink",
						fallbacks = { "buffer" },
					},
					lazydev = {
						name = "󰢱",
						module = "lazydev.integrations.blink",
						fallbacks = { "buffer" },
						score_offset = 100,
					},
					lsp = {
						name = "",
						transform_items = function(_, items)
							local new_items = {}
							for _, item in ipairs(items) do
								if item.kind ~= completion_item_kind.Text then
									table.insert(new_items, item)
								end
							end

							return new_items
						end,
					},
					latex_symbols = {
						name = "󱔁",
						module = "blink.compat.source",
						max_items = 10,
					},
					omni = {
						name = "󰊕",
					},
					path = {
						name = "",
					},
					snippets = {
						name = "",
						max_items = 10,
						score_offset = 0,
						opts = {
							search_paths = {
								vim.fn.stdpath("config") .. "/snippets",
							},
						},
						should_show_items = function(ctx)
							return ctx.trigger.initial_kind ~= "trigger_character"
						end,
					},
				},
			}

			--- @diagnostic disable param-type-mismatch
			o.sources.per_filetype = {
				latex = { "latex_symbols", inherit_defaults = true },
				lua = { "lazydev", inherit_defaults = true },
				sql = { "dadbod", inherit_defaults = true },
			}
			--- @diagnostic enable

			o.sources.per_filetype.markdown = o.sources.per_filetype.latex
			o.sources.per_filetype.mysql = o.sources.per_filetype.sql
			o.sources.per_filetype.plsql = o.sources.per_filetype.sql
		end,
	},
}
