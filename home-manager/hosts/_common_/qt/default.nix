{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	qt.enable = true;
	qt.platformTheme = "qtct"; # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
}
