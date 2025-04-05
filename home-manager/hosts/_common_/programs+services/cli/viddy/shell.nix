{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.shellAliases.watch = "${lib.getExe pkgs.viddy} --differences --deletion-differences --skip-empty-diffs";
}
