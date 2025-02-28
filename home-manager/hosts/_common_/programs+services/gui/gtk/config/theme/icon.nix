{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.iconTheme = {
		name = "Vimix-beryl-dark";
		# package = pkgs.vimix-icon-theme-beryl;
		package = pkgs.vimix-icon-theme;
	};
}
