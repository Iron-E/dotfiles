{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.iconTheme = {
		name = "Vimix-Beryl-dark";
		package = pkgs.vimix-icon-theme-beryl;
	};
}
