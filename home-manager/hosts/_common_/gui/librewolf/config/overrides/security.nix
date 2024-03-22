{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "security.${n}") {
		"disable_button.openCertManager" = false;
		"disable_button.openDeviceManager" = false;
	};
}
