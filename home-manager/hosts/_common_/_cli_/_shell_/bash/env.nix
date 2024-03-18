{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.HISTFILE = "$XDG_STATE_HOME/bash/history";
}
