{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.GRADLE_USER_HOME = "$XDG_DATA_HOME/gradle";
}
