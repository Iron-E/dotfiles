{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.configFile."yazi/init.lua".text = multiline /* lua */ ''
		require('relative-motions'):setup {
			show_motion = true,
			show_numbers = 'relative_absolute',
		};
	'';
}
