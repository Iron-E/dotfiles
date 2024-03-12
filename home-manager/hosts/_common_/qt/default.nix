{ pkgs, ... }: {
	imports = [];

	home.packages = with pkgs; [ arc-kde-theme ];

	qt.enable = true;
	qt.platformTheme = "qtct"; # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
	qt.style.name = "kvantum";

	xdg.configFile."Kvantum/kvantum.kvconfig".source = ./kvantum.kvconfig;
}
