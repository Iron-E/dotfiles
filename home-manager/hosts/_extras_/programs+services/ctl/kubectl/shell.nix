{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.shellAliases = {
		k = "kubectl";

		ka = "k apply";
		kaf = "k apply -f";

		kat = "k attach";

		kau = "k auth";
		kani = "kau can-i";

		konf = "k config";

		kcp = "k cp";

		kb = "k debug";

		krm = "k delete";
		krmf = "k delete -f";

		kd = "k diff";

		ki = "k describe";

		kv = "k events";

		kh = "k explain";

		kg = "k get";

		kl = "k logs";

		kr = "k run";

		kt = "k top";
	};
}
