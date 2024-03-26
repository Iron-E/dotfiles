{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = with config.services.redshift; [package];
	# services.redshift.enable = true; # NOTE: can't enable, wants to manage temperature automatically (I want manual control)
}
