{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.git.delta.options.interactive = {
		keep-plus-minus-markers = false;
	};
}
