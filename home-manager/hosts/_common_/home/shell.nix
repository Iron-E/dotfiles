{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		# ls
		l = "ls -l";
		la = "l -A";

		# mkdir
		mkdir = "mkdir -p";
	};
}
