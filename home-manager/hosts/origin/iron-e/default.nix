# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [../../_common_] ++ util.fs.readSubmodules ./.;

	home =
	let
		username = "iron-e";
	in {
		inherit username;
		homeDirectory = "/home/${username}";

		# SEE: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
		stateVersion = "24.05";
	};
}
