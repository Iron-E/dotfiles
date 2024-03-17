{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.packages = with pkgs; [ git-absorb ];
}
