{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git.extraConfig = {
		merge.conflictstyle = "zdiff3";
		rerere.enabled = true;
	};
}
