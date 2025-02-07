{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.packages = lib.optionals pkgs.stdenv.isDarwin (with pkgs; [
		colima

		# for docker runtime; nerdctl has env var issues
		docker-buildx
		docker-client
		docker-credential-helpers
	]);
}
