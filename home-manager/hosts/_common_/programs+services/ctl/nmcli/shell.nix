{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases.nc = "nmcli -p";
}
