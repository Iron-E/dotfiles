{ config, outputs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git.extraConfig.diff = {
		colorMoved = "default";
	};
}
