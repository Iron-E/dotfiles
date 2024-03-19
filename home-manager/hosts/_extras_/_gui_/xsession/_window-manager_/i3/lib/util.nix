{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	i3Exe = lib.getExe' config.xsession.windowManager.i3.package;
}
