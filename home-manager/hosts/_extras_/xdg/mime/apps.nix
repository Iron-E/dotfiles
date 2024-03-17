{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	xdg.mimeApps = {
		enable = true;
		defaultApplications = lib.optionalAttrs config.programs.librewolf.enable {
			"text/html" = "librewolf.desktop";
		};
	};
}
