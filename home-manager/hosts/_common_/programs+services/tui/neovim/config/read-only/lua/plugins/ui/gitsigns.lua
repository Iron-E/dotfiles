return {
	{
		"lewis6991/gitsigns.nvim",
		cmd = "Gitsigns",
		dependencies = "nvim-lua/plenary.nvim",
		event = vim.g.lazy_event_file_read,
		keys = {
			{ "[h", "<Cmd>Gitsigns prev_hunk<CR>", desc = "Previous hunk ", mode = "n" },
			{ "]h", "<Cmd>Gitsigns next_hunk<CR>", desc = "Next hunk", mode = "n" },
			{ "<A-w>C", "<Cmd>Gitsigns setqflist<CR>", desc = "Next hunk", mode = "n" },
			{ "<A-w><A-c>", "<Cmd>Gitsigns setloclist<CR>", desc = "Next hunk", mode = "n" },
			{ "<Leader>hs", "<Cmd>Gitsigns stage_hunk<CR>", desc = "Stage hunk", mode = { "n", "x" } },
			{ "<Leader>hu", "<Cmd>Gitsigns undo_stage_hunk<CR>", desc = "Unstage hunk", mode = "n" },
			{ "<A-w>b", "<Cmd>Gitsigns blame<CR>", desc = "Toggle git blame in split", mode = "n" },
			{ "<A-w>B", "<Cmd>Gitsigns blame_line<CR>", desc = "Toggle git blame as virtual text", mode = "n" },
		},
		opts = function(_, o)
			o.preview_config = { border = vim.o.winborder }
			o.trouble = false
		end,
	},
}
