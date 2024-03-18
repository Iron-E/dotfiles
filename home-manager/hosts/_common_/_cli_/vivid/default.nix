{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home = {
		packages = with pkgs; [ vivid ];
		sessionVariables = {
			LS_COLORS = "$(${lib.getExe pkgs.vivid} generate ${./highlite.yaml})";
		};
	};
}
