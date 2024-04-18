{ inputs, outputs, config, lib, pkgs, targetPlatform, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = with pkgs; [ nix-inspect ];
}
