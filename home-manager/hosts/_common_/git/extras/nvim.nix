{ config, outputs, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs = {
		neovim.enable = true;

		git.extraConfig = {
			core.editor =
			let
				env = (
					lib.findFirst
					(e: util.config.isProgramEnabled e.prog config)
					{ cmd = ""; }
					[{ cmd = "env TERM=wezterm "; prog = "wezterm"; }]
				).cmd;
			in
				"${env}${pkgs.neovim}/bin/nvim"
			;

			diff.tool = "nvim";

			merge.tool = "nvimdiff";

			mergetool =
			let
				nvimdiff.layout = "LOCAL,REMOTE / MERGED";
			in {
				inherit nvimdiff;

				# HACK: until git 2.45. See git/git#b21d164275b9186421ebe39498be47ea9f171694
				vimdiff = nvimdiff;
			};
		};
	};
}
