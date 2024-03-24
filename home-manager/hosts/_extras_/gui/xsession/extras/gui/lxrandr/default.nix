{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = lib.pipe pkgs.lxde.lxrandr [config.lib.nixgl.***REMOVED*** lib.toList];
}
