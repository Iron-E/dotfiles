{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellAbbrs = {
		cmd = "command";
		fn = "functions";
		std = "builtins";
	};
}
