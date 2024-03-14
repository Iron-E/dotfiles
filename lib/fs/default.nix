nixpkgs: # `flake`
let
	entriesToPaths = # convert output of `readDir` to list of path
	parent: # `path`
	fsEntries: # the output of `readDir`
		map (fsEntry: parent + "/${fsEntry}") (builtins.attrNames fsEntries)
	;
in {
	inherit entriesToPaths;

	readPaths = # convert output of `readDir` to list of path
	path: # `path`
		entriesToPaths path (builtins.readDir path)
	;
}
