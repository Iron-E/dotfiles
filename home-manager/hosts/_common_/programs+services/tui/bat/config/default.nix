{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = with pkgs; [less];
	programs.bat.config = {
		italic-text = "always";
		pager = "less -R";
		style = "full";
	};
}
