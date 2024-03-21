{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.git.extraConfig.init = {
		defaultBranch = "trunk"; # if only there was a word for the central BRANCH…
	};
}
