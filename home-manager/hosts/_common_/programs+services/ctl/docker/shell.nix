{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	home.shellAliases = {
		d = "docker";
		di = "docker image";
		dp = "docker pull";
		dr = "docker run";
		dx = "docker buildx build";
	};
}
