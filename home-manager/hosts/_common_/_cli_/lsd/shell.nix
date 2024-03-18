{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		"ls" = "lsd";

		"t" = "lsd --tree";
		"ta" = "t -A";
	};
}
