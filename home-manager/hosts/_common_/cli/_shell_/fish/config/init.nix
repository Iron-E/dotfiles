{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish = {
		functions = { # used below, in the init phase
			vi_bindings = {
				description = "vi keybindings with autosuggestion acceptance";
				body = multiline /* fish */ ''
					fish_vi_key_bindings
					for mode in default insert visual
						bind -M $mode -k nul forward-char
						bind -M $mode \cf forward-word
					end
				'';
			};
		};

		interactiveShellInit = multiline /* fish */ ''
			set -g fish_key_bindings vi_bindings # set keybindings
		'';
	};
}
