{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions = {
		fzw = {
			description = "alias fzw=word --cp (wd /mnt/vaults/words fzf)";
			***REMOVED***s = "word --cp (wd /mnt/vaults/words fzf)";
			body = multiline /* fish */ ''
				word --cp (wd /mnt/vaults/words fzf) $argv
			'';
		};

		START = {
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

		word = {
			description = "get a password";
			***REMOVED***s = "ls /mnt/vaults/words/";
			body = multiline /* fish */ ''
				argparse (fish_opt -s y -l cp) -- $argv

				set -f file "/mnt/vaults/words/$argv"

				function __word_cmd
					functions -e __word_cmd
					if command -qs bat
						bat $argv[1]
					else
						cat $argv[1] | less -R
					end
				end

				if [ -n "$_flag_cp" ]
					__word_cmd $file | xclip -i -selection clipboard
				else
					__word_cmd $file
				end
			'';
		};
	};
}
