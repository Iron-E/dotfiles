{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.theme = {
		name = "vimix-dark-beryl";
		package = pkgs.vimix-gtk-themes;
	};
}
