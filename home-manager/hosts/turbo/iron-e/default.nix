{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = (util.fs.readSubmodules ./.) ++ [
		../../_common_/programs+services/ctl/docker
		../../_common_/programs+services/gui/wezterm
		../../_extras_/programs+services/cli/_1password
		../../_extras_/programs+services/cli/aws
		../../_extras_/programs+services/ctl
	] ++ (util.fs.filterSubmodules ../../_common_ [
		../../_common_/home
		../../_common_/nixgl
		../../_common_/programs+services
		../../_common_/xdg
	]) ++ (util.fs.filterSubmodules ../../_common_/home [
		../../_common_/home/theme.nix
	]) ++ (util.fs.filterSubmodules ../../_common_/programs+services [
		../../_common_/programs+services/cli
		../../_common_/programs+services/ctl
		../../_common_/programs+services/gui
	]) ++ (util.fs.filterSubmodules ../../_common_/programs+services/cli [
		../../_common_/programs+services/cli/gpg
	]);

	home = {
		username = "iron-e";

		# SEE: https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
		stateVersion = "24.05";
	};

	xdg.enable = true;
}
