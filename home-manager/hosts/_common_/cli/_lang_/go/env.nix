{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home = {
		sessionPath = ["$GOPATH/bin"];
		sessionVariables.GOPATH = "$HOME/Programming/GoProjects";
	};
}
