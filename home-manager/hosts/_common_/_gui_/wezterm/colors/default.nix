{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.wezterm.colorSchemes =
	let
		ext = ".toml";
		fsEntries = builtins.readDir ./.;
		colorPaths = builtins.filter (lib.hasSuffix ext) fsEntries;
		colors =
			builtins.foldl'
			(result: path: result ++ (
				let
					name = lib.removeSuffix ext path;
					value = builtins.fromTOML (builtins.readFile path);
				in
					lib.nameValuePair name value
			))
			[]
			colorPaths
		;
	in
		builtins.listToAttrs
		colors
	;
}
