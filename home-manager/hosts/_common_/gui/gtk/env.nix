{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
}
