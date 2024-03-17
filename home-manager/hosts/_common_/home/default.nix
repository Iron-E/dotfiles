{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home = {
		enableNixpkgsReleaseCheck = true;
		homeDirectory = "/home/${config.home.username}";
	};
}
