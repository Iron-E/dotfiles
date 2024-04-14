{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.yazi = {
		keymap.manager.prepend_keymap = [
			{ on = ["<A-1>"]; run = "tab_switch 0"; desc = "Switch to the first tab"; }
			{ on = ["<A-2>"]; run = "tab_switch 1"; desc = "Switch to the second tab"; }
			{ on = ["<A-3>"]; run = "tab_switch 2"; desc = "Switch to the third tab"; }
			{ on = ["<A-4>"]; run = "tab_switch 3"; desc = "Switch to the fourth tab"; }
			{ on = ["<A-5>"]; run = "tab_switch 4"; desc = "Switch to the fifth tab"; }
			{ on = ["<A-6>"]; run = "tab_switch 5"; desc = "Switch to the sixth tab"; }
			{ on = ["<A-7>"]; run = "tab_switch 6"; desc = "Switch to the seventh tab"; }
			{ on = ["<A-8>"]; run = "tab_switch 7"; desc = "Switch to the eighth tab"; }
			{ on = ["<A-9>"]; run = "tab_switch 8"; desc = "Switch to the ninth tab"; }
		];

		settings.manager = {
			linemode = "mtime";
			ratio = [1 4 3];
			scrolloff = 0;
			show_hidden = false;
			show_symlink = true;
			sort_by = "natural";
			sort_dir_first = true;
			sort_reverse = false;
			sort_sensitive = false;
		};

		theme.manager =
		let inherit (config.programs) bat;
		in {
			syntect_theme = bat.themes.${bat.config.theme}.src;
		};
	};
}
