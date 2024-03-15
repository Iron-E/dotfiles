{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.git.extraConfig.maintenance = {
		commit-graph = true;
		gc = true;
		incremental-repack = true;
		loose-objects = true;
		pack-refs = true;
	};
}
