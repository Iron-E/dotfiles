{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionVariables.DELTA_PAGER = "${lib.getExe pkgs.bat} --style=plain";
}
