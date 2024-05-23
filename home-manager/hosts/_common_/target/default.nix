{ inputs, outputs, config, lib, pkgs, targetPlatform, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	targets.genericLinux.enable = pkgs.stdenv.isLinux;
}
