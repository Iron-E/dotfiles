{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	home = {
		enableNixpkgsReleaseCheck = true;
		homeDirectory = "/home/${config.home.username}";
		language.base = "en_US.UTF-8";
	};
}
