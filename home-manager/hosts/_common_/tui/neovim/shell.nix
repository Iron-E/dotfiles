{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases.vi = "${lib.getExe pkgs.neovim-nightly}";
}
