{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		nvim_ = "${lib.getExe pkgs.neovim}";
	};
}
