{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	programs.librewolf = {
		enable = true;
		package = config.lib.nixgl.***REMOVED*** pkgs.wezterm;
	};
}
