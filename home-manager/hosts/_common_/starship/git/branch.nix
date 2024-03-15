{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.git_branch = {
		format = "[($symbol $branch(:$remote_branch) )]($style)";
		symbol = "";
		style = "bg:green_dark fg:black";
	};
}
