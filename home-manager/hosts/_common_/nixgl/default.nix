args @ { inputs, outputs, config, lib, pkgs, targetPlatform, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	nixgl.prefix = lib.optionalString (!targetPlatform.isNixOS) (lib.getExe' pkgs.nixgl.auto.nixGLDefault "nixGL");
}
