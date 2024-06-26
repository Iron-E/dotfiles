{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	nix = {
		gc = {
			automatic = true;
			frequency = "weekly";
		};

		settings = {
			auto-optimise-store = true;
			experimental-features = ["nix-command" "flakes"];
		};
	};
}
