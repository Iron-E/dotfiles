{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.userDirs.extraConfig =
	let
		inherit (config.home) homeDirectory;
	in {
		XDG_PROG_DIR = "${homeDirectory}/Programming";
		XDG_REPO_DIR = "${homeDirectory}/Repos";
		XDG_VAULT_DIR = "${homeDirectory}/Vaults";
	};
}
