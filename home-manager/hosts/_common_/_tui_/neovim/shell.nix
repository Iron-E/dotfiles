{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		nvim = "${lib.getExe pkgs.neovim-nightly}";
		nvim-stable = "${lib.getExe pkgs.neovim}";
	};
}
