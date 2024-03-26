{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.packages = with pkgs; [less];
	programs.bat.config = {
		italic-text = "always";
		pager = "less -R";
		style = "full";
	};
}
