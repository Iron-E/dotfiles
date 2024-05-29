{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git = {
		userEmail = "<redacted>";
		userName = "<redacted>";
	};
}
