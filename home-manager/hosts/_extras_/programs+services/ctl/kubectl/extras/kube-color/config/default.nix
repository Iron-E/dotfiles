{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.sessionVariables.KUBECOLOR_CONFIG = "${config.xdg.configHome}/kubecolor.yml";
	xdg.configFile.${config.home.sessionVariables.KUBECOLOR_CONFIG}.source = ./kubecolor.yaml;
}
