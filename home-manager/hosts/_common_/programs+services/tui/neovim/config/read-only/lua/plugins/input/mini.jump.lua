--- @module 'mini.jump'

--- mode for mapping
local nvo = { 'n', 'v', 'o' }

return {{ 'echasnovski/mini.jump',
	keys = {
		{ 'F', mode = nvo, desc = 'jump backward' },
		{ 'f', mode = nvo, desc = 'jump forward' },
		{ 'T', mode = nvo, desc = 'jump backward till' },
		{ 't', mode = nvo, desc = 'jump forward till' },
		{ ';', '<Cmd>lua MiniJump.jump(nil, false, nil, vim.v.count1)<CR>',
			mode = nvo,
			desc = 'repeat previous jump',
		},
		{ ',', '<Cmd>lua MiniJump.jump(nil, true, nil, vim.v.count1)<CR>',
			mode = nvo,
			desc = 'repeat previous jump in reverse',
		},
	},
	opts = function(_, o)
		o.mappings = { repeat_jump = '' }

		vim.api.nvim_create_autocmd('CursorHold', {
			callback = function() MiniJump.stop_jumping() end,
			group = 'config',
		})
	end,
}}
