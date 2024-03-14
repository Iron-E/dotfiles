{ pkgs, ... }: {
	imports = [];

	gtk.cursorTheme = {
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
	};
}
