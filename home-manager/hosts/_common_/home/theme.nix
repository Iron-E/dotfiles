{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.pointerCursor = {
		name = "Bibata-Modern-Classic";
		package = pkgs.bibata-cursors;
	};
}
