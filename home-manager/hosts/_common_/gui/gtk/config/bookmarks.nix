{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	gtk.gtk3.bookmarks = [
		"file:///tmp"
	];
}
