{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
	activeTheme = "highlite";
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

	# activate current theme
	home.activation.setFishTheme = lib.hm.dag.entryAfter ["writeBoundary"] (multiline /* sh */ ''
		run ${lib.getExe config.programs.fish.package} -c "fish_config theme choose ${activeTheme} && fish_config theme save"
	'');
}
