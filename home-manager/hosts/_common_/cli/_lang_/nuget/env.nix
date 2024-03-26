{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.NUGET_PACKAGES =
	let
		inherit (config) xdg;
	in
		"${xdg.cacheHome}/NuGetPackages"
	;
}
