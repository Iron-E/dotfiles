{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.git_state = {
		format = outputs.lib.strings.concat [
			"[\\(]($style fg:gray_dark)"
			"[$state( $progress_current/$progress_total)]($style)"
			"[\\) ]($style fg:gray_dark)"
		];

		style = "bg:green_dark fg:black";
	};
}
