# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
{
	inputs,
	outputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		# If you want to use modules your own flake exports (from modules/home-manager):
		# outputs.homeManagerModules.example

		# Or modules exported from other flakes (such as nix-colors):
		# inputs.nix-colors.homeManagerModules.default

		# You can also split up your configuration and import pieces of it here:
		# ./nvim.nix
	];

	nixpkgs = {
		overlays = [
			# Add overlays your own flake exports (from overlays and pkgs dir):
			outputs.overlays.additions
			outputs.overlays.modifications

			# You can also add overlays exported from other flakes:
			# neovim-nightly-overlay.overlays.default

			# Or define it inline, for example:
			# (final: prev: {
			#		hi = final.hello.overrideAttrs (oldAttrs: {
			#			patches = [ ./change-hello-to-hi.patch ];
			#		});
			# })
		];
		# Configure your nixpkgs instance
		config = {
			# Disable if you don't want unfree packages
			allowUnfree = true;
		};
	};

	# Add stuff for your user as you see fit:
	# programs.neovim.enable = true;
	# home.packages = with pkgs; [ steam ];

	# Enable home-manager and git
	programs.home-manager.enable = true;
	programs.git.enable = true;

	# Nicely reload system units when changing configs
	systemd.user.startServices = "sd-switch";
}
