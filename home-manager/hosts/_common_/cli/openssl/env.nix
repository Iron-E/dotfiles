{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.RANDFILE =
	let
		inherit (config) xdg;
	in
		"${xdg.dataHome}/openssl/rnd"
	;
}
