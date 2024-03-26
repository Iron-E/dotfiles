{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables =
	let
		inherit (config) xdg;
	in {
		PYTHON_HISTORY = "${xdg.stateHome}/python/history";
		PYTHONPYCACHEPREFIX = "${xdg.cacheHome}/python";
		PYTHONUSERBASE = "${xdg.dataHome}/python";
	};
}
