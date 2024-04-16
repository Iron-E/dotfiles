{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionVariables =
	let inherit (config) xdg;
	in {
		KUBECACHEDIR = "${xdg.cacheHome}/kube";
		KUBECONFIG = "${xdg.configHome}/kube";
	};
}
