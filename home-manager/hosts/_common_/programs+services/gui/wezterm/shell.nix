{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases =
	let inherit (config.programs.neovim) enable finalPackage;
	in lib.optionalAttrs enable {
		nvim = "env TERM=wezterm ${lib.getExe finalPackage}";
	};
}
