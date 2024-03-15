{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings.jobs = {
		format = outputs.lib.strings.concat [
			"[](bg:black fg:gray_darker)"
			"[ $number$symbol ]($style)"
			"[]($style fg:black)"
		];

		style = "bg:gray_darker fg:blue";
	};
}
