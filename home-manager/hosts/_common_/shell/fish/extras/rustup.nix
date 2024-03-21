{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellInit = multiline /* fish */ ''
		set -gx PATH $PATH $XDG_DATA_HOME/rustup/toolchains/stable-*/bin
	'';
}
