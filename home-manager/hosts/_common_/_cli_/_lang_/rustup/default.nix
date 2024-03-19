{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	home = {
		packages = [pkgs.rustup];
		sessionVariables.RUSTUP_HOME = "$XDG_DATA_HOME/rustup";
	};
}