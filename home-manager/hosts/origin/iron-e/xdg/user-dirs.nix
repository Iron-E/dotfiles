{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.userDirs.extraConfig = {
		XDG_PROG_DIR = "${config.home.homeDirectory}/Programming";
		XDG_REPO_DIR = "${config.home.homeDirectory}/Repos";
		XDG_VAULT_DIR = "${config.home.homeDirectory}/Vaults";
	};
}
