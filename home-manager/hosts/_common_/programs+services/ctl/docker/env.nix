{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionVariables =
	let inherit (config) xdg;
	in {
		DOCKER_CONFIG = "${xdg.configHome}/docker";
	};
}
