{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home = {
		enableNixpkgsReleaseCheck = true;
		homeDirectory = "/home/${config.home.username}";
		language.base = "en_US.UTF-8";

		pointerCursor = {
			name = "Bibata-Modern-Classic";
			package = pkgs.bibata-cursors;
		};

		sessionPath = [
			"$HOME/bin"
			"$HOME/.local/bin"
		];

		sessionVariables = {
			DO_NOT_TRACK = 1;
		};
	};
}
