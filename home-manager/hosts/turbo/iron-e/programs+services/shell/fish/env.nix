{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellInit =
	let
		inherit (config) home;
	in multiline /* fish */ ''
		# HACK: fish on MacOS does not seem to load the nix env
		set -gx PATH ${home.homeDirectory}/.nix-profile/bin $PATH
	'';
}
