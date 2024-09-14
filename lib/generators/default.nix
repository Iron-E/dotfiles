nixpkgs: # `flake`
let
	inherit (nixpkgs) lib;
	inherit (lib) generators;
in {
	toXmodmap =
	let
		generator = generators.toKeyValue {
			mkKeyValue =
			let
				_mkKeyValue =
					generators.mkKeyValueDefault
					{
						mkValueString =
						let
							fallback = generators.mkValueStringDefault {};
							typeConverters = {
								list =
								v:
									let converted = map _mkValueString v;
									in builtins.concatStringsSep " " converted
								;

								null = lib.const "";
							};

							_mkValueString =
							v:
								let
									type = builtins.typeOf v;
									converter = lib.attrByPath [type] fallback typeConverters;
								in
									converter v
							;
						in
							_mkValueString
						;
					}
					" = "
				;
			in
			k:
				let
					key =
						if builtins.match "^[0-9]+$" k == null then k
						else "keycode ${k}"
					;
				in
					_mkKeyValue key
			;
		};
	in
	attrs: lib.concatLines [
		"clear lock"
		""
		(generator attrs)
		""
		("! vim" + ": ft\=xmodmap") # NOTE: must split up string or Vim uses it for THIS file
	];
}
