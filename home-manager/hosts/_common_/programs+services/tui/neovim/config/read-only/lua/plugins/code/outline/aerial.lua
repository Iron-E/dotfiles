return {{ 'stevearc/aerial.nvim',
	dependencies = { 'nvim-treesitter', 'nvim-web-devicons' },
	keys = {{ 'gO', '<Cmd>AerialToggle<CR>', desc = 'Toggle aerial.nvim', mode = 'n' }},
	opts = function(_, o)
		o.backends = { 'lsp', 'treesitter', 'man', 'markdown' }
		o.filter_kind = false
		o.icons =
		{
			Array         = '󱡠',
			Boolean       = '󰨙',
			Class         = '󰆧',
			Constant      = '󰏿',
			Constructor   = '',
			Enum          = '',
			EnumMember    = '',
			Event         = '',
			Field         = '',
			File          = '󰈙',
			Function      = '󰊕',
			Interface     = '',
			Key           = '󰌋',
			Method        = '󰊕',
			Module        = '',
			Namespace     = '󰦮',
			Null          = '󰟢',
			Number        = '󰎠',
			Object        = '',
			Operator      = '󰆕',
			Package       = '',
			Property      = '',
			String        = '',
			Struct        = '󰆼',
			TypeParameter = '󰗴',
			Variable      = '󰀫',
			ArrayCollapsed         = '󱡠 ',
			BooleanCollapsed       = '󰨙',
			ClassCollapsed         = '󰆧 ',
			ConstantCollapsed      = '󰏿',
			ConstructorCollapsed   = ' ',
			EnumCollapsed          = ' ',
			EnumMemberCollapsed    = ' ',
			EventCollapsed         = ' ',
			FieldCollapsed         = ' ',
			FileCollapsed          = '󰈙 ',
			FunctionCollapsed      = '󰊕 ',
			InterfaceCollapsed     = ' ',
			KeyCollapsed           = '󰌋 ',
			MethodCollapsed        = '󰊕 ',
			ModuleCollapsed        = ' ',
			NamespaceCollapsed     = '󰦮 ',
			NullCollapsed          = '󰟢',
			NumberCollapsed        = '󰎠',
			ObjectCollapsed        = ' ',
			OperatorCollapsed      = '󰆕 ',
			PackageCollapsed       = ' ',
			PropertyCollapsed      = ' ',
			StringCollapsed        = '',
			StructCollapsed        = '󰆼 ',
			TypeParameterCollapsed = '󰗴',
			VariableCollapsed      = '󰀫',
		}
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
