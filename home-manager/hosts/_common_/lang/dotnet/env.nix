{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables.DOTNET_CLI_TELEMETRY_OPTOUT = "true";
}
