{
	description = "Iron-E's dotfiles";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		nixgl = { # required for wezterm
			url = "github:nix-community/nixGL";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# overlays

		neovim-nightly-overlay = {
			url = "github:nix-community/neovim-nightly-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		# non-flakes

		i3blocks-contrib = { flake = false; url = "github:vivien/i3blocks-contrib"; };
		i3switch = { flake = false; url = "github:lokeshlkr/i3switch"; };
		yazi-relative-motions = { flake = false; url = "github:dedukun/relative-motions.yazi"; };
	};

	outputs = inputs @ { self, nixpkgs, home-manager, ... }:
	let
		inherit (self) outputs;
		lib = import ./lib nixpkgs;
	in {
		inherit lib;

		# allows nixOS config to use home-manager as a nixOS module
		hosts = ./home-manager/hosts;

		# Accessible through 'nix build', 'nix shell', etc
		packages = lib.systems.genValues (system: nixpkgs.lib.mergeAttrsList [
			(import ./pkgs nixpkgs.legacyPackages.${system}) # Your custom packages
			{ home-manager = home-manager.packages.${system}.default; } # `nix run .#home-manager`
		]);

		# Formatter for your nix files, available through 'nix fmt'
		# TODO: https://github.com/kamadorueda/alejandra/issues/387
		# formatter = lib.systems.genValues (system: nixpkgs.legacyPackages.${system}.alejandra);

		# Your custom packages and modifications, exported as overlays
		overlays = import ./overlays { inherit inputs; };

		# Reusable home-manager modules you might want to export. Usually things you would upstream into home-manager
		homeManagerModules = import ./home-manager/modules;
	} // (lib.config.declare ./. home-manager {
		origin = {
			args = { inherit inputs outputs; architecture = "x86_64-linux"; };
			iron-e = {}; # Available through 'home-manager --flake .#iron-e@origin'
		};

		turbo = {
			args = { inherit inputs outputs; architecture = "aarch64-darwin"; };
			iron-e = {}; # Available through 'home-manager --flake .#iron-e@turbo'
		};
	});
}
