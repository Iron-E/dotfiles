{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.git.delta.options = {
		navigate = true;
		line-numbers = true;
		syntax-theme = # try to get the bat theme, falling back to `DarkNeon`
			lib.attrByPath
			["programs" "bat" "config" "theme"]
			"DarkNeon"
			config
		;
	};
}
