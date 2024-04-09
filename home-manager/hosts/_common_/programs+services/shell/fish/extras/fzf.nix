{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.interactiveShellInit =
	let inherit (config) home programs;
	in lib.optionalString (programs.fzf.enable && (builtins.elem pkgs.fd home.packages)) (multiline /* fish */ ''
		set -g FZF_ALT_C_COMMAND 'fd -t d --search-path $dir'
		set -g FZF_CTRL_T_COMMAND 'fd -t f --search-path $dir'
	'');
}
