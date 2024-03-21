args @ { inputs, outputs, config, lib, pkgs, keys ? {}, ... }:
let
	util = outputs.lib;

	inherit (lib) flatten flip intersperse pipe toList;
	inherit (util.attrsets) pair;
	inherit (util.strings) multiline;

	enterMode = name: ''mode "${name}"'';
	exec = cmd: "exec '${multiline cmd}'";
	execInBg = cmd: "exec --no-startup-id '${multiline cmd}'";

	keys' = lib.mergeAttrsList [
		{
			alt = "Mod1"; mod = "Mod4"; shift = "Shift";
			greater = "greater"; less = "less";
			down = "Down"; left = "Left"; right = "Right"; up = "Up";
			escape = "Escape"; return = "Return"; space = "space"; tab = "Tab";
		}
		keys
	];

	prefixLhsWith = fn: key: keys: fn (flatten [key keys]); # prefix the `lhs`  fn with `key`
	lhs = keys: lib.concatStrings (intersperse "+" (toList keys)); # create the lhs of a mapping

	lhsAlt = prefixLhsWith lhs keys'.alt; # `lhs` but prepend `mod`
	lhsMod = prefixLhsWith lhs keys'.mod; # `lhs` but prepend `mod`
	lhsModAlt = prefixLhsWith lhsMod keys'.alt; # `lhs` but prepend `mod` and `shift`
	lhsModShift = prefixLhsWith lhsMod keys'.shift; # `lhs` but prepend `mod` and `shift`
in keys' // {
	inherit
		enterMode exec execInBg
		lhs lhsAlt lhsMod lhsModAlt lhsModShift prefixLhsWith
	;

	genDirectionMaps = let directions = with keys'; [left down up right]; in
	rhsKeyFn: # rhs mapper, e.g. lib.toLower
	lhsFn: # the lhs mapping function (e.g. `lhs`, `lhsMod`)
	rhsFn: # the rhs mapping function (e.g. `v: "move ${v}"`)
	lhsKeyFn: # lhs mapper, e.g. lib.id
		builtins.listToAttrs (
			map
			(key: let pipe' = pipe key; in
				lib.nameValuePair
				(pipe' [lhsKeyFn lhsFn])
				(pipe' [rhsKeyFn rhsFn])
			)
			directions
		)
	;

	getVimDirection =
		let vimDirections = with keys'; { ${down} = "j"; ${left} = "h"; ${right} = "l"; ${up} = "k"; };
		in lib.flip builtins.getAttr vimDirections
	;
}
