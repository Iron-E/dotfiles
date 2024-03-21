{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		# some terminals don't clear history correctly
		clr = "clear && clear";

		# ls
		l = "ls -l";
		la = "l -A";

		# mkdir
		mkdir = "mkdir -p";

		# nmcli
		nc = "nmcli -p";

		# xclip
		P = "xclip -o -selection clipboard";
		Y = "xclip -i -selection clipboard";
	};
}
