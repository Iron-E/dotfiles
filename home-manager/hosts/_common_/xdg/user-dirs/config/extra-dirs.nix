{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.userDirs.extraConfig = {
		XDG_BIN_DIR = "${config.home.homeDirectory}/.local/bin";
	};

	home.sessionPath = with config.xdg.userDirs.extraConfig; [
		XDG_BIN_DIR
	];
}
