{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
	activeTheme = "highlite";
in {
	imports = [];

	xdg.configFile."fish/themes/${activeTheme}.theme".source = ./${activeTheme}.theme;

	home.activation.setFishTheme = lib.hm.dag.entryAfter ["writeBoundary"] (multiline /* sh */ ''
		run ${lib.getExe config.programs.fish.package} -c "fish_config theme choose ${activeTheme} && fish_config theme save"
	'');
}
