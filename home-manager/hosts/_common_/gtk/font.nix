{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.font = {
		name = "Ubuntu";
		package = pkgs.ubuntu_font_family;
		size = 10;
	};
}
