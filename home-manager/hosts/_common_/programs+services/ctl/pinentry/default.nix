{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	# NOTE: requires services.dbus.packages = [ pkgs.gcr ];
	lib.pinentry.package = pkgs.pinentry-gnome3;
}
