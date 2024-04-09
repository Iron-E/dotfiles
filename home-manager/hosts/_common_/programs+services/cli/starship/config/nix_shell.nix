{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	# this can be massively simplified after starship/starship#4945
	programs.starship.settings.nix_shell = {
		disabled = false;
		heuristic = true; # detect `nix shell`
		format = "[](bg:black fg:cyan)[ $symbol$state$name ](fg:black bg:cyan)";
		impure_msg = "\\(impure\\) ";
		pure_msg = "\\(pure\\) ";
		symbol = " ";
	};
}
