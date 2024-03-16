{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.wezterm = {
		enable = true;
		extraConfig = builtins.readFile ./wezterm.lua;
	};
}
