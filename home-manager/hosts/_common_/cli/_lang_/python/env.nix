{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables = {
		PYTHON_HISTORY = "$XDG_STATE_HOME/python/history";
		PYTHONPYCACHEPREFIX = "$XDG_CACHE_HOME/python";
		PYTHONUSERBASE = "$XDG_DATA_HOME/python";
	};
}
