{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionVariables.CARGO_HOME =
	let
		inherit (config) xdg;
	in
		"${xdg.dataHome}/cargo"
	;
}
