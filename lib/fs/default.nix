nixpkgs: # `flake`
let
	entriesToPaths = # convert output of `readDir` to list of path
	parent: # `path`
	fsEntries: # the output of `readDir`
		map (fsEntry: parent + "/${fsEntry}") (builtins.attrNames fsEntries)
	;

	readPaths = # convert output of `readDir` to list of path
	path: # `path`
		entriesToPaths path (builtins.readDir path)
	;
in {
	inherit entriesToPaths readPaths;

	readPathsExceptDefault = # read all paths from the `path` except 'default.nix'
	path:
		builtins.filter (p: p != path + "/default.nix") (readPaths path)
	;
}
