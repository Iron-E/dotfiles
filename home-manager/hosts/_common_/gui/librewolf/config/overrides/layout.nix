{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "layout.${n}") {
		"css.color-mix.enabled" = true;
		"css.has-selector.enabled" = true;
	};
}
