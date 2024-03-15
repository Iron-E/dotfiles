{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git.extraConfig.diff = {
		colorMoved = "default";
	};
}
