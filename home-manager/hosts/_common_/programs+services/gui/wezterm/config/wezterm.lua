--- @class config
local config = wezterm.config_builder and wezterm.config_builder() or {}

-- FIXME: https://github.com/wez/wezterm/issues/5990
config.front_end = "WebGpu"

--[[ appearance ]]
config.color_scheme = 'highlite'

config.font_size = 14
config.harfbuzz_features = { 'zero' }
config.font = wezterm.font_with_fallback { 'JetBrains Mono', { family = 'Symbols Nerd Font Mono', scale = 0.8 } }
config.font_rules = {
	{intensity = 'Bold', italic = false, font = wezterm.font('JetBrains Mono', { weight = 'ExtraBold' })},
	{intensity = 'Bold', italic = true, font = wezterm.font('JetBrains Mono', { style = 'Italic', weight = 'ExtraBold' })},
}

config.hide_tab_bar_if_only_one_tab = true
config.use_fancy_tab_bar = false -- TODO: set to `true`; see wez/wezterm#2615

config.window_background_opacity = 1.0
config.window_padding = {bottom = 0, left = 0, right = 0, top = 0}
config.xcursor_theme = 'Bibata-Modern-Classic'

do -- determine if nix has wezterm files installed
	local terminfo_dirs = wezterm.home_dir .. '/.nix-profile/share/terminfo'
	if pcall(wezterm.read_dir, terminfo_dirs .. '/w') then -- terminfo may not be installed
		config.set_environment_variables = {
			TERMINFO_DIRS = terminfo_dirs,
			WSLENV = 'TERMINFO_DIRS',
		}
		config.term = 'wezterm'
	end
end

--[[ clicks ]]
config.hyperlink_rules = wezterm.default_hyperlink_rules()

do
	--- A template link to github.com
	local github_link = 'https://www.github.com/$1/$2'

	--- a github repo name (e.g. `wez/wezterm`)
	local github_shortcut = [[([\w\d]{1}[-\w\d]+)/{1}([-\w\d\.]+)]]

	--- punctuation that may surround a github shortcut
	local punctuation = '[\'"`<\\[\\(\\{\\}\\)\\]>]?'

	table.insert(config.hyperlink_rules, {
		format = github_link .. '/issues/$3',
		regex = punctuation .. github_shortcut .. [[#(\d+)]] .. punctuation
	})

	table.insert(config.hyperlink_rules, {format = github_link, regex = punctuation .. github_shortcut .. punctuation})
end

do
	local action = wezterm.action
	local close_current_tab = action.CloseCurrentTab { confirm = true }

	--[[ keybindings ]]
	config.keys = {
		{ mods = 'ALT', key = 'Space', action = action.ShowLauncherArgs { flags = 'LAUNCH_MENU_ITEMS' } },

		{ mods = 'CTRL|ALT', key = 'h', action = action.ActivatePaneDirection 'Left' },
		{ mods = 'CTRL|ALT', key = 'j', action = action.ActivatePaneDirection 'Down' },
		{ mods = 'CTRL|ALT', key = 'k', action = action.ActivatePaneDirection 'Up' },
		{ mods = 'CTRL|ALT', key = 'l', action = action.ActivatePaneDirection 'Right' },

		{ mods = 'CTRL|SHIFT', key = 'q', action = close_current_tab },
		{ mods = 'CTRL|SHIFT', key = 't', action = action.SpawnTab 'CurrentPaneDomain' },
		{ mods = 'CTRL|SHIFT', key = 'w', action = action.ActivateKeyTable { name = 'split', one_shot = true } },
	}

	--- @param direction 'Left'|'Down'|'Right'|'Up'
	local function resize_pane(direction)
		return action.Multiple {
			action.AdjustPaneSize { direction, 1 },
			action.ActivateKeyTable { name = 'split', one_shot = true, timeout_milliseconds = 1000 },
		}
	end

	--[[ modes ]]
	config.key_tables = {
		split = {
			{ key = 'h', action = action.ActivatePaneDirection 'Left' },
			{ key = 'j', action = action.ActivatePaneDirection 'Down' },
			{ key = 'k', action = action.ActivatePaneDirection 'Up' },
			{ key = 'l', action = action.ActivatePaneDirection 'Right' },

			{ key = 'w', action = action.ActivatePaneDirection 'Next' },
			{ key = 'b', action = action.ActivatePaneDirection 'Prev' },

			{ key = 'r', action = action.RotatePanes 'Clockwise' },
			{ key = 'R', action = action.RotatePanes 'CounterClockwise' },

			{ key = ',', action = resize_pane 'Left' },
			{ key = '-', action = resize_pane 'Down' },
			{ key = '.', action = resize_pane 'Right' },
			{ key = '=', action = resize_pane 'Up' },

			{ key = 'n', action = wezterm.action_callback(function(_, pane)
				pane:move_to_new_window()
			end) },

			{ key = 't', action = wezterm.action_callback(function(_, pane)
				pane:move_to_new_tab()
			end) },

			{ key = 's', action = action.SplitVertical { domain = 'CurrentPaneDomain' } },
			{ key = 'v', action = action.SplitHorizontal { domain = 'CurrentPaneDomain' } },

			{ key = 'q', action = action.CloseCurrentPane { confirm = true } },
		}
	}
end

do
	local config_dir = wezterm.home_dir .. '/Documents/nix/home'
	local nvim = {  'nvim', '-c', 'Telescope find_files' }

	--- @param program string
	--- @param path string
	--- @param parent_dir? string
	--- @return table launch
	local function edit_config(program, path, parent_dir)
		return {
			label = program .. ' config',
			args = nvim,
			cwd = (parent_dir or config_dir) .. '/' .. path,
		}
	end

	--[[ misc. features ]]
	config.launch_menu = {
		-- other options are `set_environment_variables`
		edit_config('home-manager', '.'),
		{ label = 'List Processes by CPU', args = { 'procs', '--sortd', 'cpu' } },
		{ label = 'Test internet', args = { 'gping', '1.1.1.1' } },
	}
end

return config
