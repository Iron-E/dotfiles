nixpkgs:
let
	inherit (nixpkgs) lib;
in
{
	concat =
	attrsets:
		builtins.foldl'
		recursiveUpdate
		{}
		attrsets
	;
}
