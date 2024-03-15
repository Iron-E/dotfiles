{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	name = "ArcDarker";
	package = pkgs.arc-kde-theme;
}
