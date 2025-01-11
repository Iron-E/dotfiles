{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.packages = with pkgs.nerd-fonts; [open-dyslexic];
	xsession.windowManager.i3.config.fonts = {
		names = ["OpenDyslexicNerdFont"];
		style = "Regular";
		size = 11.0;
	};
}
