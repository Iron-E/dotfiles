{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionSearchVariables.PATH = lib.optional pkgs.stdenv.isDarwin "/opt/homebrew/bin";
}
