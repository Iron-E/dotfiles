{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.gpg = {
		mutableKeys = true;
		mutableTrust = true;
	};
}
