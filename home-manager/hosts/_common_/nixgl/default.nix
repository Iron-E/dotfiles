{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	nixGLPrefix = "${lib.getExe' pkgs.nixgl.auto.nixGLDefault "nixGLDefault"}";
}
