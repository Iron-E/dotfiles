{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.packages = with pkgs; [
		nerdfonts-jetbrains-mono # monospace font
		nerdfonts-open-dyslexic # (sans) serif font
	];

	fonts.fontconfig.defaultFonts = {
		monospace = ["JetBrainsMono Nerd Font Mono"];
		serif = ["OpenDyslexic Nerd Font"];
		sansSerif = config.fonts.fontconfig.defaultFonts.serif;
	};
}
