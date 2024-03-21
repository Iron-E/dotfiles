{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	programs.i3blocks = {
		enable = true;

		# HACK: have to define bars manually, as home-manager does not support
		#       the global attributes.
		#       however, this option must be explicitly set or else an error
		#       occurs.
		bars = {};
	};
}
