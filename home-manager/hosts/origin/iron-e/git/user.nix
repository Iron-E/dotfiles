{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git = {
		userEmail = "code.iron.e@gmail.com";
		userName = "Iron-E";
	};
}
