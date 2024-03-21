{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.nnn.bookmarks = {
		d = "~/Documents";
		p = "~/Programming";
		t = "~/Documents/Tabletop";
	};
}
