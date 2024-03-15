{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.zathura.options.selection-clipboard = "clipboard";
}
