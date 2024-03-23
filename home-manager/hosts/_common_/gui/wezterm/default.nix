args @ { inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
	withNixGL = util.nixgl.mkWrapper args;
in {
	imports = util.fs.readSubmodules ./.;

	programs.wezterm = {
		enable = true;
		package = (withNixGL pkgs.wezterm);
	};
}
