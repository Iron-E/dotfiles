{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions.git-diff-merge = {
		description = "Get the diff between (the current branch and its origin) and ((the main branch) and (the commit the current branch's origin branched from master))";
	};
}
