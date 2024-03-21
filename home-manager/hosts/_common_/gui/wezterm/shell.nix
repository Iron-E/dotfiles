{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = lib.optionalAttrs config.programs.neovim.enable (
		let env = cmd: "env TERM=wezterm ${cmd}";
		in {
			nvim = env "nvim";
			nvim_ = lib.pipe pkgs.neovim [lib.getExe env lib.mkForce];
		}
	);
}
