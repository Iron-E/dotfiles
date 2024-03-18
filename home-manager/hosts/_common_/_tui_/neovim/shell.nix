{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		nvim = "${lib.getBin pkgs.neovim-nightly}";
		nvim-stable = "${lib.getBin pkgs.neovim}";
	};
}
