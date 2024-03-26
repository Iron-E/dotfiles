{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	# NOTE: requires services.dbus.packages = [ pkgs.gcr ];
	services.gpg-agent.pinentryPackage = config.lib.nixgl.wrap pkgs.pinentry-gnome3;
}
