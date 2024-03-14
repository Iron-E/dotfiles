nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;
	inherit (lib) concatLines concatStrings flatten pipe toList;

	join' = # join the nested list of strings together without any separator
	fn: # the fn to join with
	stringLists: # `[[string]]`
		fn (pipe stringLists [toList flatten])
	;
in {
	inherit concat concatLines isLine toLine;

	joinLines = # join the nested list of strings together as lines
	stringLists: # `[[string]]`
	let
		strings = builtins.concatLists stringLists;
	in concatLines
		strings
	;
}
