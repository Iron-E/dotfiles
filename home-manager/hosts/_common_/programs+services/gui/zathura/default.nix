{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	programs.zathura = {
		enable = true;
		package = config.lib.nixgl.wrap pkgs.zathura;
	};
}