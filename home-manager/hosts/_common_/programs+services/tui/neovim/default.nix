{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	programs.neovim = {
		enable = true;
		# package = inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;
	};
}
