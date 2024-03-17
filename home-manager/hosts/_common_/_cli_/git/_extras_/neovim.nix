{ inputs, outputs, lib, config, pkgs, ... }:
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
					(v: config.${v.scope}.${v.name}.enable)
					{ cmd = ""; }
					[{ cmd = "env TERM=wezterm "; name = "wezterm"; scope = "programs"; }]
				).cmd;
			in
				"${env}${lib.getBin config.programs.neovim.package}"
			;

			diff.tool = "nvim";

			merge.tool = "nvimdiff";

			mergetool =
			let nvimdiff.layout = "LOCAL,REMOTE / MERGED";
			in {
				inherit nvimdiff;

				# HACK: until git 2.45. See git/git#b21d164275b9186421ebe39498be47ea9f171694
				vimdiff = nvimdiff;
			};
		};
	};
}
