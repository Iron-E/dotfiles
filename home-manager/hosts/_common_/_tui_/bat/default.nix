{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = [pkgs.less];
	programs.bat = {
		enable = true;
		config = {
			italic-text = "always";
			pager = "less -R";
			style = "full";
		};
	};
}
