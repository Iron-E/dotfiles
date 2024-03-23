# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
args @ { inputs, outputs, lib, config, pkgs, ... }: {
	imports =
		# builtins.filter (path: path == ./foo) /* NOTE: for testing */
		(outputs.lib.fs.readSubmodules ./.)
	;

	nixpkgs =
		outputs.lib.config.nixpkgs
		(with inputs; [neovim-nightly-overlay nixgl])
		(with outputs.overlays; [additions modifications])
		{}
	;

	# Nicely reload system units when changing configs
	# systemd.user.startServices = "sd-switch";
}
