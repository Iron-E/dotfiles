{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = lib.optionals pkgs.stdenv.isLinux (with pkgs; [k3s]);
}
