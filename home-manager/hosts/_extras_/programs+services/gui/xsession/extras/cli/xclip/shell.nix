{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		P = "xclip -o -selection clipboard";
		Y = "xclip -i -selection clipboard";
	};
}
