{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.yazi = {
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
