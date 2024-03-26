{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.bat = {
		config.theme = "highlite";
		themes.highlite.src = ./highlite.tmTheme;
	};
}
