--- @module 'mini.icons'

return {{ 'stevearc/aerial.nvim',
	dependencies = {
		'nvim-treesitter',
		'echasnovski/mini.icons',
	},

	keys = {
		{ 'gO', '<Cmd>AerialToggle<CR>', desc = 'Toggle aerial.nvim', mode = 'n' },

		-- HACK: neovim provides gO as a builtin on markdown files, so we must override it.
		--       nvim_buf_del_keymap works but throws an error.
		{ 'gO', '<Cmd>AerialToggle<CR>', desc = 'Toggle aerial.nvim', mode = 'n', ft = 'markdown' },
	},

	init = function()
		vim.api.nvim_create_autocmd('FileType', {
			desc = 'Fix folds in aerial',
			group = 'config',
			pattern = 'aerial',
			command = 'set foldmethod=manual',
		})
	end,

	opts = function(_, o)
		o.backends = { 'lsp', 'treesitter', 'man', 'markdown' }
		o.filter_kind = false
		o.icons =
			vim.iter(ipairs {
				'Array',
				'Class',
				'Constructor',
				'Enum',
				'EnumMember',
				'Event',
				'Field',
				'File',
				'Function',
				'Interface',
				'Key',
				'Method',
				'Module',
				'Namespace',
				'Object',
				'Operator',
				'Package',
				'Property',
				'Struct',
			})
			:fold({}, function(acc, _, v)
				local icon = MiniIcons.get('lsp', v)
				acc[v..'Collapsed'] = icon .. ' '
				return acc
			end)

		o.layout =
		{
			default_direction = 'right',
			max_width = {40, 0.25}
		}

		o.guides =
		{
			last_item = '└─ ',
			mid_item = '├─ ',
			nested_top = '│  ',
			whitespace = '   ',
		}

		o.keymaps =
		{
			['?'] = false,
			['[['] = 'actions.prev',
			['[]'] = 'actions.prev_up',
			[']['] = 'actions.next_up',
			[']]'] = 'actions.next',
		}

		o.show_guides = true
	end,
}}
