{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = lib.optionalAttrs config.programs.neovim.enable (
		let env = pkg: lib.mkForce "env TERM=wezterm ${lib.getExe pkg}";
		in {
			nvim = env pkgs.neovim-nightly;
			nvim-stable = env pkgs.neovim;
		}
	);
}
