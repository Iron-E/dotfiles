nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;

	entriesToPaths = # convert output of `readDir` to list of path
	parent: # `path`
	fsEntries: # the output of `readDir`
		map (fsEntry: parent + "/${fsEntry}") (builtins.attrNames fsEntries)
	;

	filterDir = # filter the output of `readDir`
	pred: # `filterAttrs` predicate
	path: # `path`
		lib.filterAttrs pred (builtins.readDir path)
	;

	filterDirToPaths = # `readDir` the path and then convert the output to a list of paths
	pred: # `filterAttrs` predicate
	path: # `path`
		entriesToPaths path (filterDir pred path)
	;
in {
	inherit entriesToPaths filterDir filterDirToPaths;

	readPathsInDir = # `readDir` the path and then convert the output to a list of paths
	path: # `path`
		filterDirToPaths (_: _: true) path
	;
}
