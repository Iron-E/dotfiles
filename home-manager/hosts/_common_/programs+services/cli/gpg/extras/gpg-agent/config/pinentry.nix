{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	services.gpg-agent.pinentryPackage = config.lib.pinentry.package;
}
