{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = lib.optionalAttrs config.programs.neovim.enable (
		let
			env = pkg: "env TERM=wezterm ${lib.getExe pkg}";
		in {
			nvim = env config.programs.neovim.finalPackage;
			vi = lib.pipe pkgs.neovim-nightly [env lib.mkForce];
		}
	);
}
