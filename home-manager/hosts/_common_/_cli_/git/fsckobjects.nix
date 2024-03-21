{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.git.extraConfig =
		lib.genAttrs
		["fetch" "receive" "transfer"]
		(lib.const { fsckobjects = true; })
	;
}
