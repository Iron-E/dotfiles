{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.bat = {
		enable = true;
		config = {
			italic-text = "always";
			pager = "less -R";
			style = "full";
		};
	};
}
