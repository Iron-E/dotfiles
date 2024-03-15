{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	services.picom = {
		activeOpacity = 1;
		settings.frame-opacity = 1;
		inactiveOpacity = 0.90;
		menuOpacity = 0.85;
	};
}
