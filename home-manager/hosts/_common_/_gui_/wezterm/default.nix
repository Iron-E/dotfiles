{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = with pkgs; [jetbrains-mono nerdfonts];
	programs.wezterm = {
		enable = true;
		extraConfig = builtins.readFile ./config.lua;
	};
}
