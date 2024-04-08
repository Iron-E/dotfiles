{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		# some terminals don't clear history correctly
		clr = "clear && clear";

		# iproute2
		ip = "ip --color";

		# ls
		l = "ls -l";
		la = "l -A";

		# mkdir
		mkdir = "mkdir -p";
	};
}
