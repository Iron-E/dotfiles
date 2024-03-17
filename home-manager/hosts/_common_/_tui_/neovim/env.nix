{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.sessionVariables = {
		EDITOR = "nvim";
		MANPAGER = "nvim --cmd 'let g:man = v:true' +Man!";
	};
}
