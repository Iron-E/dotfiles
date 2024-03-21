{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.configFile = lib.mapAttrs' (n: lib.nameValuePair "fish/themes/${n}.theme") {
		highlite = {
			source = ./highlite.theme;
			onChange = multiline /* sh */ ''
				fish_config theme choose highlite
				fish_config theme save
			'';
		};
	};
}
