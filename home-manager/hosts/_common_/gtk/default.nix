{ pkgs, ... }: {
	imports = [];

	gtk.enable = true;

	gtk.cursorTheme = {
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
	};

	gtk.font = {
		name = "Ubuntu";
		package = pkgs.ubuntu_font_family;
		size = 10;
	};

	gtk.iconTheme = {
		name = "Papirus-Dark";
		package = pkgs.papirus-icon-theme;
	};

	gtk.theme = {
		name = "vimix-dark-beryl";
		package = pkgs.vimix-gtk-themes;
	};
}
