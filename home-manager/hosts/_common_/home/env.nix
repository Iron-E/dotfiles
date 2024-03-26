{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home =
	let
		inherit (config.home) homeDirectory;
	in {
		sessionPath = [
			"${homeDirectory}/bin"
			"${homeDirectory}/.local/bin"
		];

		sessionVariables.DO_NOT_TRACK = 1;
	};
}
