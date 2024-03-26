{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	nix.settings = {
		experimental-features = ["nix-command" "flakes"];
	};
}
