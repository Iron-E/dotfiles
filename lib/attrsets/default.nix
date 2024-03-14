nixpkgs:
let inherit (nixpkgs.lib) attrByPath nameValuePair optionalAttrs recursiveUpdate;
in {
	concat = # recursively merges a list of attrsets together
	attrsets:
		builtins.foldl'
		recursiveUpdate
		{}
		attrsets
	;

	optionalMapAttrByPath = # @returns output of `fn` or empty set
	attrPath: # string[]
	set: # attrset
	fn: # `attrset: any`
	let attrs = attrByPath attrPath null set;
	in if attrs == null then {}
		else fn attrs
	;
}
