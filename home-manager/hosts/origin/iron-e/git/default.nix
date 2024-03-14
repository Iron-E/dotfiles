{ outputs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;
}
