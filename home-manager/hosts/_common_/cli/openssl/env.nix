{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.RANDFILE = "$XDG_DATA_HOME/openssl/rnd";
}
