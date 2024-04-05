{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.configFile."fish/completions/minikube.fish".text = multiline /* fish */ ''
		if command -qs minikube
			minikube completion fish | source
		end
	'';
}
