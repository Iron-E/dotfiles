{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.NUGET_PACKAGES = "$XDG_CACHE_HOME/NuGetPackages";
}
