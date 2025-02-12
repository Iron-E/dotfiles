{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		n = "nerdctl";
		ne = "nerdctl exec";
		ni = "nerdctl image";
		nil = "nerdctl image ls";
		nin = "nerdctl image inspect";
		nir = "nerdctl image rm";
		np = "nerdctl pull";
		nr = "nerdctl run --rm";
		nx = "nerdctl buildx build";
	};
}
