{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	# HACK: nixgl doesn't work on macos, but we still want to install the config
	programs.wezterm.package = lib.mkForce pkgs.emptyDirectory;
}
