{ pkgs, ... }: {
	imports = [];

	gtk.font = {
		name = "Ubuntu";
		package = pkgs.ubuntu_font_family;
		size = 10;
	};
}
