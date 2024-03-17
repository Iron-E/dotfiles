nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;
in {
	repeat = # what `repeat 5 [2 3 4]` is equal to `[2, 3, 4] * 5` in python
	count: # integer
	list: # to repeat
		let replicated = lib.lists.replicate count (lib.toList list);
		in builtins.concatLists replicated
	;

	zipOn = # like `zipOn'`, but final list length is determined by the longest list
	value:
	left:
	right:
		let
			lengths = map length [left right];
			maxLen = builtins.foldl' lib.max 0 lengths;
			reserveMaxLen = reserve maxLen;
		in
			zipOn'
			value
			(reserveMaxLen left)
			(reserveMaxLen right)
	;
}
