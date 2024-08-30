{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellAbbrs = lib.optionalAttrs config.programs.bat.enable (let
		mkHelpAbbr = # create a help abbreviation to colorize with bat
		flagSuffix: # `String` the suffix of the help flag, e.g. `h` for `-h`, or `-help` for `--help`.
		let flag = "-${flagSuffix}";
		in lib.nameValuePair flag {
			expansion = "${flag} | bat -l help -pp";
			position = "anywhere";
		};

		abbreviations = map mkHelpAbbr ["h" "help" "-help"];
	in
		builtins.listToAttrs abbreviations
	);
}
