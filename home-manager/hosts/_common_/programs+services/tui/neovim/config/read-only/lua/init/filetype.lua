--[[
 _____ _ _      _
|  ___(_) | ___| |_ _   _ _ __   ___
| |_  | | |/ _ \ __| | | | '_ \ / _ \
|  _| | | |  __/ |_| |_| | |_) |  __/
|_|   |_|_|\___|\__|\__, | .__/ \___|
                    |___/|_|
--]]

vim.filetype.add {
	filename = {
		['.dockerignore'] = 'dockerignore',
		['fish_history'] = 'yaml',
	},

	extension = {
		conf = 'dosini',
		tf = 'terraform',
	},
}
