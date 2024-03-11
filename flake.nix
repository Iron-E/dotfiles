{
	description = "Iron-E's dotfiles";

	inputs = {
		nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

		home-manager = {
			url = "github:nix-community/home-manager";
			inputs.nixpkgs.follows = "nixpkgs";
		};

		neovim-nightly-overlay = {
			url = "github:nix-community/neovim-nightly-overlay";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = inputs @ {
		self,
		nixpkgs,
		nixos-hardware,
		home-manager,
		...
	}: let
		inherit (self) outputs;
		lib = import ./lib nixpkgs;
	in {
		inherit lib;

		# Your custom packages
		# Accessible through 'nix build', 'nix shell', etc
		packages = lib.systems.genValues (system: import ./pkgs nixpkgs.legacyPackages.${system});

		# Formatter for your nix files, available through 'nix fmt'
		# TODO: https://github.com/kamadorueda/alejandra/issues/387
		# formatter = util.genSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

		# Your custom packages and modifications, exported as overlays
		overlays = import ./overlays { inherit inputs; };

		# Reusable home-manager modules you might want to export. Usually things you would upstream into home-manager
		homeManagerModules = import ./home-manager/modules;
	} // (lib.config.declare ./home-manager/hosts home-manager {
		origin = {
			args = {
				inherit inputs outputs;
				system = "x86_64-linux";
			};

			# Available through 'home-manager --flake .#iron-e@origin'
			iron-e = {};
		};
	});
}
