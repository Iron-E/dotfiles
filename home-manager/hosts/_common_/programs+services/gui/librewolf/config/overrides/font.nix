{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	# needed for default font settings
	home.packages = with pkgs; [jetbrains-mono nerdfonts-open-dyslexic];
	programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "font.${n}") {
		"minimum-size.x-western" = 18;
		"name.monospace.x-western" = "JetBrains Mono";
		"name.sans-serif.x-western" = "OpenDyslexic Nerd Font";
		"name.serif.x-western" = "OpenDyslexic Nerd Font";
		"size.monospace.x-western" = 14;
		"size.variable.x-western" = 18;
	};
}
