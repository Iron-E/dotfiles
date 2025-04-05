{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellInit = lib.optionalString pkgs.stdenv.isDarwin
	(multiline /* fish */ ''
		if command -qs brew # homebrew is installed
			brew shellenv | source
		end
	'');
}
