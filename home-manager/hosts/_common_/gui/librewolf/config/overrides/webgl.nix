{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "webgl.${n}") {
		disabled = true;
	};
}
