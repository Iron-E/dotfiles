{ inputs, outputs, lib, config, pkgs, ... }:
let
	inherit (builtins) fromTOML readFile getAttr;
	util = outputs.lib;

	getColorsFromTOML = lib.flip lib.pipe [fromTOML (getAttr "colors")];
in {
	imports = [];

	programs.wezterm.colorSchemes = {
		highlite = lib.pipe ./highlite.toml [readFile getColorsFromTOML];
	};
}
