return {
	{
		"chrisgrieser/nvim-scissors",
		dependencies = "ibhagwan/fzf-lua",

		keys = {
			{
				"<A-w>s",
				function()
					require("scissors").addNewSnippet()
				end,
				desc = "Add snippet with scissors",
				mode = { "n", "x" },
			},
			{
				"<A-w>S",
				function()
					require("scissors").editSnippet()
				end,
				desc = "Edit snippet with scissors",
				mode = "n",
			},
		},

		opts = function(_, o)
			o.jsonFormatter = { "gojq", "--monochrome-output", "--tab" }
			o.editSnippetPopup = {
				height = 0.85, -- relative to the window, number between 0 and 1
				width = 0.8,
				keymaps = {
					deleteSnippet = "<Leader>d",
					duplicateSnippet = "<Leader>r",
				},
			}
		end,
	},
}
