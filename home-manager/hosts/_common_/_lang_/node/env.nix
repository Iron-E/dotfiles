{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.NODE_REPL_HISTORY = "$XDG_DATA_HOME/node_repl_history";
}
