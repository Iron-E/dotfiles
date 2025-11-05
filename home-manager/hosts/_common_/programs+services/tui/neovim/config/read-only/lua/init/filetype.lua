--[[
 _____ _ _      _
|  ___(_) | ___| |_ _   _ _ __   ___
| |_  | | |/ _ \ __| | | | '_ \ / _ \
|  _| | | |  __/ |_| |_| | |_) |  __/
|_|   |_|_|\___|\__|\__, | .__/ \___|
                    |___/|_|
--]]

--- @param path string the path which may be in a helm chart
--- @return boolean
local function in_helm_chart(path)
	return vim.fs.root(path, 'Chart.yaml') ~= nil
end

vim.filetype.add {
	filename = {
		['compose.yaml'] = 'yaml.docker-compose',
		['compose.yml'] = 'yaml.docker-compose',
		['docker-compose.yaml'] = 'yaml.docker-compose',
		['docker-compose.yml'] = 'yaml.docker-compose',
		['fish_history'] = 'yaml',
		['librewolf.overrides.cfg'] = 'javascript',
	},

	extension = {
		conf = 'dosini',
		dockerignore = 'dockerignore',
		env = 'env',
		envrc = 'sh',
		helmignore = 'helmignore',
		tf = 'terraform',
		tmpl = 'gotmpl',
		tpl = 'gotmpl',
		xkb = 'xkb',
		yaml = 'yaml',
		yml = 'yaml',
	},

	pattern = {
		['.*/[^/]*%.gitlab%-ci%.ya?ml'] = 'yaml.gitlab',

		['.*/[Tt]askfile[^/]*%.ya?ml'] = 'yaml.taskfile',

		['.*/templates/_.*%.tm?pl'] = function(path)
			if in_helm_chart(path) then
				return 'helm'
			end
		end,

		['.*/[^/]*values.ya?ml'] = function(path)
			if in_helm_chart(path) then
				return 'yaml.helm-values'
			end
		end,

		['.*/templates/.*%.ya?ml'] = {
			function(path)
				if in_helm_chart(path) then
					return 'helm'
				end
			end,

			-- takes priority over values.yaml resolution
			{ priority = 1, },
		}
	},
}
