{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git = {
		userEmail = builtins.getEnv "GIT_USER_EMAIL";
		userName = builtins.getEnv "GIT_USER_NAME";
	};
}
