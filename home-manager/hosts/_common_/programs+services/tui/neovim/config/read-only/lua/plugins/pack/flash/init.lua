--- @module 'lazy'
--- @module 'flash'

vim.keymap.set({ "n", "x", "o" }, "<Space>", '<Cmd>lua require("flash").jump()<CR>', {
	desc = "Flash",
})

vim.keymap.set({ "n", "x", "o" }, "<C-Space>", '<Cmd>lua require("flash").treesitter_search()<CR>', {
	desc = "Flash Treesitter Search",
})

vim.keymap.set({ "n", "x", "o" }, "<A-v>", '<Cmd>lua require("flash").treesitter()<CR>', {
	desc = "Flash Treesitter",
})

vim.keymap.set("o", "r", '<Cmd>lua require("flash").remote()<CR>', {
	desc = "Remote Flash",
})

--- SEE: https://github.com/folke/flash.nvim/issues/380#issuecomment-3255575807
vim.keymap.set({ "o", "x" }, "R", function()
	local register = vim.v.register
	require("flash").treesitter_search({
		action = function(match, state)
			require("flash.jump").remote_op(match, state, register)
		end,
	})
end, {
	desc = "Remote Flash Treesitter Search",
})

vim.keymap.set("c", "<C-s>", '<Cmd>lua require("flash").toggle()<CR>', {
	desc = "Toggle Flash Search",
})

require("flash").setup({
	modes = {
		char = {
			highlight = {
				backdrop = false,
				groups = {
					label = "FlashMatch",
				},
			},

			--- @param _ 'f'|'F'|'t'|'T' the motion
			char_actions = function(_)
				return {
					[";"] = "right", -- default "next"
					[","] = "left", -- default "prev"

					-- -- jump2d style: same case goes next, opposite case goes prev
					-- [motion] = "next",
					-- [motion:match("%l") and motion:upper() or motion:lower()] = "prev",
				}
			end,
		},

		treesitter = {
			actions = {
				[";"] = "next",
				[","] = "prev",
			},

			highlight = {
				backdrop = true,
			},

			label = {
				rainbow = {
					enabled = true,
				},
			},
		},

		treesitter_search = {
			label = {
				rainbow = {
					enabled = true,
				},
			},
		},
	},
})
