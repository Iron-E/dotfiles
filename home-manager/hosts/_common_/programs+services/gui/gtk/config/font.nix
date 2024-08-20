{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.font = {
		name = "Ubuntu";
		package = pkgs.ubuntu-sans;
		size = 10;
	};
}
