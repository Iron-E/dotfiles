{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions.START = {
		description = "system startup commands";
		body = multiline /* fish */ ''
			argparse (fish_opt -s a -l all) -- $argv

			# Update nameservers using /etc/resolvconf.conf
			sudo resolvconf -u

			# Power settings
			sudo powertop --auto-tune
			sudo tlp start

			if [ -n "$_flag_all" ]
				# update system
				sudo pacman -Syu

				# update neovim
				nvim +'lua vim.defer_fn(function() vim.cmd "Lazy sync" end, 100)'
			end
		'';
	};
}
