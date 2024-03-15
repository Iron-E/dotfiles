{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = outputs.lib.fs.readSubmodules ./.;

	services.picom.enable = true;
}
