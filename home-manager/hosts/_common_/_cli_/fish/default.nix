{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.fish.enable = true;
	xdg.configFile.fish.source = ./config;
}
