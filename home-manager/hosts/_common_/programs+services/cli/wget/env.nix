{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables =
	let
		inherit (config) xdg;
	in {
		WGETRC = "${xdg.configHome}/wgetrc";
	};
}
