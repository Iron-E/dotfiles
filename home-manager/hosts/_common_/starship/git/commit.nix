{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.git_commit = {
		format = "[( $hash )( $tag )]($style)";
		only_detached = true;
		tag_symbol = "";
		tag_disabled = false;
		style = "bg:green_dark fg:black";
	};
}
