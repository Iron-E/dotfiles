{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.neovim.defaultEditor = true;
	home.sessionVariables = {
		MANPAGER = "nvim --cmd 'let g:man = v:true' +Man!";
	};
}
