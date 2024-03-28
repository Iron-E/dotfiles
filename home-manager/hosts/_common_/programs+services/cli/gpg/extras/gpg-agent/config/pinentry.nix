{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	services.gpg-agent.pinentryPackage = pkgs.pinentry-gtk2;
}
