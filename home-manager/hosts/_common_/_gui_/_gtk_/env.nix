{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.GTK2_RC_FILES = lib.mkForce "$XDG_CONFIG_HOME/gtk-2.0/gtkrc";
}
