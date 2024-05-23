{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = (util.fs.readSubmodules ./.) ++ [
		../../_common_/editorconfig
		../../_common_/fonts
		../../_common_/home/config.nix
		../../_common_/home/env.nix
		../../_common_/home/shell.nix
		../../_common_/nixpkgs
		../../_common_/programs+services/ctl/docker
		../../_common_/programs+services/lang
		../../_common_/programs+services/shell
		../../_common_/programs+services/tui
		../../_common_/target
		../../_extras_/programs+services/cli
		../../_extras_/programs+services/ctl
	] ++ (
		builtins.filter
		(p: p != ../../_common_/programs+services/cli/gpg)
		(util.fs.readSubmodules ../../_common_/programs+services/cli)
	);

	home = {
		username = "iron-e";

		# SEE: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
		stateVersion = "24.05";
	};

	xdg.enable = true;
}
