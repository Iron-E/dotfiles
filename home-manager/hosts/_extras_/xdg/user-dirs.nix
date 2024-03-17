{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	xdg.userDirs = {
		enable = true;
		createDirectories = true;

		extraConfig =
			let dir = s: "${config.home.homeDirectory}/${s}";
			in { XDG_VAULT_DIR = dir "Vaults"; }
		;
	};
}
