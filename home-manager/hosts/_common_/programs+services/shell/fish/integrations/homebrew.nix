{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.shellInit = lib.optionalString pkgs.stdenv.isDarwin
	(let
		homebrewPath = "/opt/homebrew";
	in multiline /* fish */ ''
		if test -d ${homebrewPath} # homebrew is installed
			set -gx PATH $PATH ${homebrewPath}/bin
			brew shellenv | source
		end
	'');
}
