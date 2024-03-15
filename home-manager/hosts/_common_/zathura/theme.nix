{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.zathura.options = {
		recolor = "true";
		recolor-darkcolor = "#E0E0E0";
		recolor-keephue = "true";
		recolor-lightcolor = "#000000";
		recolor-reverse-video = "true";
	};
}
