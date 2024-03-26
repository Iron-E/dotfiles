{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.GNUPGHOME =
	let
		inherit (config) xdg;
	in
		"${xdg.dataHome}/gnupg"
	;
}
