{ outputs, ... }: {
	imports = outputs.lib.fs.readSubmodules ./.;

	qt.enable = true;
	qt.platformTheme = "qtct"; # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
}
