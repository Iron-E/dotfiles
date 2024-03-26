{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.GRADLE_USER_HOME =
	let
		inherit (config) xdg;
	in
		"${xdg.dataHome}/gradle"
	;
}
