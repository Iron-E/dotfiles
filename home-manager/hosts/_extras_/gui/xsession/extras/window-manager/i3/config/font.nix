{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.packages = with pkgs; [nerdfonts-open-dyslexic];
	xsession.windowManager.i3.config.fonts = {
		names = ["OpenDyslexic"];
		style = "Regular";
		size = 11.0;
	};
}
