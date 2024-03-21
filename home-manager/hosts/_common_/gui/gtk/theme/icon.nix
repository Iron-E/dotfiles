{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.iconTheme = {
		name = "Papirus-Dark";
		package = pkgs.papirus-icon-theme;
	};
}
