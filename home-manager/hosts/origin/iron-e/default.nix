# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = (util.fs.readSubmodules ./.) ++ [
		../../_common_
		../../_extras_/_gui_/xsession
		../../_extras_/xdg/mime
	];

	home = {
		username = "iron-e";

		# SEE: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
		stateVersion = "24.05";
	};
}
