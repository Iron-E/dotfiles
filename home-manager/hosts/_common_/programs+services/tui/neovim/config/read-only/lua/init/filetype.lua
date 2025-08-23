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
		helmignore = 'helmignore',
		env = 'env',
		envrc = 'sh',
		tf = 'terraform',
		tmpl = 'gotmpl',
		tpl = 'gotmpl',
	},

	pattern = {
		['.*/[^/]*%.gitlab%-ci%.ya?ml'] = 'yaml.gitlab',

		['.*/values.ya?ml'] = function(path)
			if in_helm_chart(path) then
				return 'yaml.helm-values'
			end

			return 'yaml'
		end,

		['.*/templates/.*%.ya?ml'] = {
			function(path)
				if in_helm_chart(path) then
					return 'helm'
				end

				return 'yaml'
			end,

			-- takes priority over values.yaml resolution
			{ priority = 1, },
		}
	},
}
