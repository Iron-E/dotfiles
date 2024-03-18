{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home = {
		sessionPath = [
			"$HOME/bin"
			"$HOME/.local/bin"
		];

		sessionVariables = {
			DO_NOT_TRACK = 1;
		};
	};
}
