{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.HISTFILE =
	let
		inherit (config) xdg;
	in
		"${xdg.stateHome}/bash/history"
	;
}
