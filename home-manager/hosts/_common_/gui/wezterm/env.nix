{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionVariables = {
		MPLBACKEND = "module://matplotlib-backend-wezterm";
	};
}
