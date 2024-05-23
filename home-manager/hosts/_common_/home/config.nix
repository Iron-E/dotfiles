{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home = {
		enableNixpkgsReleaseCheck = true;
		homeDirectory = "/${if pkgs.stdenv.isDarwin then "Users" else "home"}/${config.home.username}";
		language.base = "en_US.UTF-8";
	};
}
