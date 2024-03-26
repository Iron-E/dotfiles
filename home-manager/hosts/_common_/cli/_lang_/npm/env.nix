{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home =
	let
		inherit (config) xdg;
	in {
		sessionPath = ["${xdg.dataHome}/npm/bin"];
		sessionVariables.NPM_CONFIG_USERCONFIG = "${xdg.configHome}/npm/npmrc";
	};
}
