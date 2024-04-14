{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	xdg.configFile."yazi/plugins/relative-motions.yazi".source = "${inputs.yazi-relative-motions}";
}
