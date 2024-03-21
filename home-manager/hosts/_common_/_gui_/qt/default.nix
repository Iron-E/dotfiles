{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	qt.enable = true;
	qt.platformTheme = "gtk3"; # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
	# qt.style.name = config.gtk.theme.name; # might be needed?
}
