require("guess-indent").setup({
	auto_cmd = false,
	override_editorconfig = true,
	on_space_options = {
		expandtab = true,
		tabstop = "detected",
		shiftwidth = 0,
		softtabstop = -1,
	},
})
