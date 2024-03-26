{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home = {
		packages = [pkgs.rustup];
		sessionVariables.RUSTUP_HOME =
		let
			inherit (config) xdg;
		in
			"${xdg.dataHome}/rustup"
		;
	};
}
