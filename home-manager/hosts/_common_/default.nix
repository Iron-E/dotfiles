# This is your home-manager configuration file
# Use this to configure your home environment (it replaces ~/.config/nixpkgs/home.nix)
args @ {
	inputs,
	outputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [
		./bat
		./cargo
		./fish
		./fontconfig
		./gtk
		./lsd
		./maven
		./picom
		./qt

		# TODO: ./git
		# TODO: ./i3
		# TODO: ./nvim
		# TODO: ./starship
		# TODO: ./Typora
		# TODO: ./wezterm
		# TODO: ./zathura
	];

	nixpkgs = outputs.lib.config.nixpkgs args {
		# overlays = [
			# Or define it inline, for example:
			# (final: prev: {
			#		hi = final.hello.overrideAttrs (oldAttrs: {
			#			patches = [ ./change-hello-to-hi.patch ];
			#		});
			# })
		# ];
	};

	# Add stuff for your user as you see fit:
	# programs.neovim.enable = true;

	# Enable home-manager and git
	programs.home-manager.enable = true;

	# Nicely reload system units when changing configs
	# systemd.user.startServices = "sd-switch";
}
