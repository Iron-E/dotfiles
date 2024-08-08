{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.direnv = {
		format = "[$symbol $loaded$allowed]($style)";
		symbol = "direnv";
		style = "bg:purple fg:white";
		allowed_msg = " ";
		not_allowed_msg = " ";
		denied_msg = " ";
		loaded_msg = " ";
	};
}
