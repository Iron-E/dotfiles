{ inputs, outputs, config, lib, pkgs, ... }:
let
	inherit (lib) getExe toList;

	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	xsession.windowManager.i3.config.startup = toList {
		always = true;
		command = "${getExe config.programs.feh.package} --bg-fill ${config.xdg.userDirs.pictures}/wallpaper.png";
		notification = false;
	};
}
