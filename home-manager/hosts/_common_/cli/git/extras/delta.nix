{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git.delta = {
		enable = true;
		options = {
			navigate = true;
			line-numbers = true;
			syntax-theme = # try to get the bat theme, falling back to `DarkNeon`
				lib.attrByPath
				["programs" "bat" "config" "theme"]
				"DarkNeon"
				config
			;

			interactive = {
				keep-plus-minus-markers = false;
			};
		};
	};
}
