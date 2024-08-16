{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	programs.rbw.settings = {
		email = builtins.getEnv "BW_EMAIL";
		pinentry = config.lib.pinentry.package;
	};
}
