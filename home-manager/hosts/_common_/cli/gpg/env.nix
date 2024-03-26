{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.gpg.homedir =
	let
		inherit (config) xdg;
	in
		"${xdg.dataHome}/gnupg"
	;
}
