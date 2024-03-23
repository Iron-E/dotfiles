{ lib, ... }: # nixpkgs flake
let
	inherit (lib) concatLines concatStrings flatten pipe toList;

	join' = # join the nested list of strings together without any separator
	fn: # the fn to join with
	stringLists: # `[[string]]`
		fn (pipe stringLists [toList flatten])
	;
in {
	join = join' concatStrings;
	joinLines = join' concatLines;

	multiline = # HACK: see https://github.com/NixOS/nix/issues/3759#issuecomment-653033810
	text:
		let
			# Whether all lines start with a tab (or is empty)
			shouldStripTab = lines: builtins.all (line: (line == "") || (lib.strings.hasPrefix "	" line)) lines;
			# Strip a leading tab from all lines
			stripTab = lines: builtins.map (line: lib.strings.removePrefix "	" line) lines;
			# Strip tabs recursively until there are none
			stripTabs = lines: if (shouldStripTab lines) then (stripTabs (stripTab lines)) else lines;
		in
			# Split into lines. Strip leading tabs. Concat back to string.
			builtins.concatStringsSep
			"\n"
			(stripTabs (lib.strings.splitString "\n" text))
	;
}
