args @ { inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;

	inherit (import ./lib/colors.nix args) auto presets;
	focusedInactive = auto presets.inactive;
in {
	imports = [];

	xsession.windowManager.i3.config.colors = {
		inherit focusedInactive;
		unfocused = focusedInactive;

		focused = auto {};
		urgent = auto presets.urgent;
	};
}
