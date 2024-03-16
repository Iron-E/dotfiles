{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.packages = with pkgs; [ vivid ];
	xdg.configFile."vivid/highlite.yaml".source = ./highlite.yaml;
}
