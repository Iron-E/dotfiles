nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;

	optionalMapAttrByPath =
	attrPath: # string[]
	set: # attrset
	fn: # `attrset: any`
	# @returns output of `fn` or empty set
	let attrs = lib.attrByPath attrPath null set;
	in if attrs == null then {}
		else fn attrs
	;
in {
	inherit optionalMapAttrByPath;
}
