{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables._JAVA_OPTIONS =
	let
		inherit (config) xdg;
	in
		"-Djava.util.prefs.userRoot=${xdg.configHome}/java"
	;
}
