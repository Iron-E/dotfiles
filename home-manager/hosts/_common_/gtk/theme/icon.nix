{ pkgs, ... }: {
	imports = [];

	gtk.iconTheme = {
		name = "Papirus-Dark";
		package = pkgs.papirus-icon-theme;
	};
}