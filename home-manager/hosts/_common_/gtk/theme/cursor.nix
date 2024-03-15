{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	gtk.cursorTheme = {
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
	};
}
