{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = with pkgs; [wget];
}
