{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = outputs.lib.fs.readSubmodules ./.;

	programs.starship.enable = true;
	programs.starship.settings."$schema" = "https://starship.rs/config-schema.json";
}
