args @ { inputs, outputs, config, lib, pkgs, isNixOS, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	nixgl.prefix = lib.optionalString (!isNixOS) "${lib.getExe' pkgs.nixgl.auto.nixGLDefault "nixGL"}";
}
