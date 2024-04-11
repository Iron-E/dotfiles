{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	# because `gh` is short for `git show`
	home.shellAliases.github = lib.getExe config.programs.gh.package;
}
