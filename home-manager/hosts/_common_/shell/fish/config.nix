{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.configFile.fish = {
		source = config.lib.file.mkOutOfStoreSymlink ./config;
		recursive = true;
	};
}
