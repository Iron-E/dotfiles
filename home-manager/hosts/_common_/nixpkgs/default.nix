{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	nixpkgs =
		outputs.lib.config.nixpkgs
		(with inputs; [neovim-nightly-overlay nixgl])
		(with outputs.overlays; [additions modifications])
		{}
	;
}
