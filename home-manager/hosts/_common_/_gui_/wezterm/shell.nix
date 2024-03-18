{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = lib.optionalAttrs config.programs.neovim.enable (
		let
			hasPrefix = lib.hasPrefix "nvim";
			oldAliases =
				lib.filterAttrs
				(n: v: hasPrefix n)
				config.home.shellAliases
			;
		in
			lib.mapAttrs
			oldAliases
			(alias: cmd: "env TERM=wezterm ${cmd}")
	);
}
