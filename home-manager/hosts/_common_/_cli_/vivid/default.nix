{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home = {
		packages = with pkgs; [ vivid ];
		sessionVariables = {
			LS_COLORS = "$(${lib.getBin pkgs.vivid} generate ${./highlite.yaml})";
		};
	};
}
