nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;

	reserveWith = # grows the list to at least the given size using `fn`
	fn: # `(integer) -> T`
	size: # `integer`
	list: # `[T]`
	let
		sizeDiff = lib.max 0 (size - (length list));
		reserved = builtins.genList (builtins.add sizeDiff) sizeDiff;
		reservedWith = map fn reserved;
	in
		list ++ reservedWith
	;

	reserve = reserveWith (lib.const null);

	zipOn' = # `zipListsWith` a check to see if a value in the `left` list is equal to `value`, and if so, choose the corresponding `right` value instead
	value: # the value to use for deferring from `left` to `right` (e.g. `null`)
	left: # the left list. has priority
	right: # the right list. values only get selected when a `left` element `== value`
		lib.zipListsWith
		(l: r: if l == value then r else left)
		left
		right
	;
in {
	inherit reserve reserveWith zipOn';

	index = # like `builtins.elemAt` but negative indexing works
	list: let listLength = length list; in
	i: let idx = if i < 0 then listLength + i else i; in
		builtins.elemAt list idx
	;

	# like builtin map but convert `list` to a list first
	map = fn: list: map fn (toList list);

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
