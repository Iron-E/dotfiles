{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xsession.windowManager.i3.extraConfig = multiline /* i3Config */ ''
		for_window [all] title_window_icon padding 4px
	'';
}
