args @ { inputs, outputs, config, lib, pkgs, workspaces ? [], ... }:
let
	util = outputs.lib;

	workspaces' =
	let
		workspaceCount = 10;
		defaultWorkspaces =
			util.lists.reserveWith
			(builtins.add 1)
			workspaceCount
			["1 | Browsers" "2 | Misc" "3 | Editors" "4 | Background" "5 | Comms"]
		;
	in
		util.lists.zipOn
		null
		workspaces
		defaultWorkspaces
	;
in {
	workspaces = workspaces';

	workspace = # the name of the workspace at the `idx`
	idx: # integer 1-10 of the workspace
		util.lists.index
		workspaces'
		(idx - 1)
	;
}
