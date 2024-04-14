{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.shellAliases =
	let inherit (config.programs) neovim wezterm;
	in lib.optionalAttrs wezterm.enable {
		nvim = "env TERM=wezterm ${lib.getExe neovim.finalPackage}";
	};
}
