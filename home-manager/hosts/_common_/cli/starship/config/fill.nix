{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.fill = {
		symbol = "·";
		style = "gray";
	};
}
