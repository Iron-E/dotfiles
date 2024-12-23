{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions =
	let inherit (config) home;
	in lib.optionalAttrs (builtins.elem pkgs._1password-cli home.packages) {
		opr = {
			description = "run program with 1password injection";
			wraps = "op run -- ";
			body = multiline /* fish */ ''
				op run -- $argv
			'';
		};

		opre = {
			description = "run program with 1password injection from the env file provided";
			wraps = "op run -- ";
			body = multiline /* fish */ ''
				op run --env-file=$argv[1] -- $argv[2..]
			'';
		};
	};
}
