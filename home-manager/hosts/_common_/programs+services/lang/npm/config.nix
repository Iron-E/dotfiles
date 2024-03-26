{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.file.${config.home.sessionVariables.NPM_CONFIG_USERCONFIG}.text = lib.generators.toKeyValue {} {
		prefix = "\${XDG_DATA_HOME}/npm";
		cache = "\${XDG_CACHE_HOME}/npm";
		init-module = "\${XDG_CONFIG_HOME}/npm/config/npm-init.js";
		logs-dir = "\${XDG_STATE_HOME}/npm/logs";
	};
}
