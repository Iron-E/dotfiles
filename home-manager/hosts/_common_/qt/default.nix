{ outputs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	qt.enable = true;
	qt.platformTheme = "qtct"; # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
}
