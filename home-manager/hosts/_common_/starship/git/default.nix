{ config, lib, outputs, ... }:
let
	util = outputs.lib;
in {
	imports = lib.optionals config.programs.git.enable (util.fs.readSubmodules ./.);
}
