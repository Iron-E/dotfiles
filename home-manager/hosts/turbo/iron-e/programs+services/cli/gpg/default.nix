{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = (util.fs.readSubmodules ./.) ++ [
		../../../../../_common_/programs+services/cli/gpg/env.nix
		../../../../../_common_/programs+services/cli/gpg/config
	];

	programs.gpg.enable = true;
}
