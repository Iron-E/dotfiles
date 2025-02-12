{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home = {
		sessionVariables.GOJQ_COLORS = config.home.sessionVariables.JQ_COLORS;
		shellAliases.jq = "gojq";
	};
}
