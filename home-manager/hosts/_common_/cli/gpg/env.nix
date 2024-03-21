{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.GNUPGHOME = "$XDG_DATA_HOME/gnupg";
}
