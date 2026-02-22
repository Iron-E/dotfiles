--- @module 'lazy'

--- @type LazySpec[]
return {
	{
		"mbbill/undotree",
		cmd = {
			"UndotreeFocus",
			"UndotreeHide",
			"UndotreePersistUndo",
			"UndotreeShow",
			"UndotreeToggle",
		},

		keys = { {
			"<A-w>u",
			"<Cmd>UndotreeToggle<CR>",
			mode = "n",
		} },
	},
}
