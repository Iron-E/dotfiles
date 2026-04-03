vim.keymap.set({ "n", "x" }, "<A-w>s", function()
	require("scissors").addNewSnippet()
end, { desc = "Add snippet with scissors" })

vim.keymap.set("n", "<A-w>S", function()
	require("scissors").editSnippet()
end, { desc = "Edit snippet with scissors" })

require("scissors").setup({
	jsonFormatter = { "gojq", "--monochrome-output", "--tab" },
	editSnippetPopup = {
		height = 0.85, -- relative to the window, number between 0 and 1
		width = 0.8,
		keymaps = {
			deleteSnippet = "<Leader>d",
			duplicateSnippet = "<Leader>r",
		},
	},
})
