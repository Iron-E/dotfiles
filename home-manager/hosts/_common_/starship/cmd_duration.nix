{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.cmd_duration = {
		format = "[]($style inverted)[ $duration ]($style)";
		style = "fg:black bg:tan";
	};
}
