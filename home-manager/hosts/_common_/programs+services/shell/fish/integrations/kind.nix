{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions =
	let inherit (config) home programs;
	in lib.optionalAttrs (programs.fzf.enable && (builtins.elem pkgs.kind home.packages)) {
		kindf = {
			description = "fuzzy find `kind` resources";
			wraps = "kind get";
			body = multiline /* fish */ ''
				kind get $argv[1] | fzf
			'';
		};
	};
}
