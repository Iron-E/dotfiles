{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionSearchVariables =
	let
		searchDirectories = [
			config.home.profileDirectory
			"/nix/var/nix/profiles/default"
		];
	in {
		PATH = map (dir: "${dir}/bin") searchDirectories;
		MANPATH = map (dir: "${dir}/share/man") searchDirectories;
	};
}
