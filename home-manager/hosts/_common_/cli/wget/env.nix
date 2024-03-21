{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.WGETRC = "$XDG_CONFIG_HOME/wgetrc";
}
