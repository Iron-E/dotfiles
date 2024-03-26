{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.gtk2.configLocation =
	let
		inherit (config) xdg;
	in
		"${xdg.configHome}/gtk-2.0/gtkrc"
	;
}
