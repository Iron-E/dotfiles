{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellAbbrs = lib.optionalAttrs config.programs.bat.enable (let
		help = {
			expansion = "--help | bat -l help -pp";
			position = "anywhere";
		};
	in {
		"-h" = help;
		"--help" = help;
	});
}
