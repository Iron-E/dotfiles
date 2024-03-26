{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.LS_COLORS = "$(${lib.getExe pkgs.vivid} generate ${./highlite.yaml})";
}
