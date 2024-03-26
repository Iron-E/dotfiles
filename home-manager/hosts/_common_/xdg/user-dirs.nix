{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	xdg.userDirs = {
		enable = true;
		createDirectories = true;
	};
}
