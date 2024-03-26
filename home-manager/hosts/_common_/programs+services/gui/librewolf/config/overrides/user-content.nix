{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "userContent.${n}") {
		"newTab.animate" = true;
		"newTab.field_border" = true;
		"newTab.full_icon" = true;
		"newTab.pocket_to_last" = true;
		"newTab.searchbar" = true;
		"page.dark_mode" = true;
		"page.field_border" = true;
		"page.illustration" = true;
		"page.proton" = true;
		"page.proton_color" = true;
		"player.animate" = true;
		"player.click_to_play" = true;
		"player.icon" = true;
		"player.noaudio" = true;
		"player.size" = true;
		"player.ui" = true;
	};
}
