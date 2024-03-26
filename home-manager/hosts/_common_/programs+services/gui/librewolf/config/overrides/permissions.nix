{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "permissions.${n}") {
		"default.camera" = 2;
		"default.desktop-notification" = 2;
		"default.geo" = 2;
		"default.microphone" = 2;
		"default.xr" = 2;
	};
}
