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
		['.env'] = 'env',
		['.envrc'] = 'sh',
		['compose.yaml'] = 'yaml.docker-compose',
		['compose.yml'] = 'yaml.docker-compose',
		['docker-compose.yaml'] = 'yaml.docker-compose',
		['docker-compose.yml'] = 'yaml.docker-compose',
		['fish_history'] = 'yaml',
		['librewolf.overrides.cfg'] = 'javascript',
	},

	extension = {
		conf = 'dosini',
		tf = 'terraform',
		tmpl = 'gotmpl',
	},

	pattern = {
		['.*/charts/.*/templates/.*%.ya?ml'] = 'helm',
	},
}
