{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionVariables =
	let awsConfigDir = "${config.xdg.configHome}/aws";
	in {
		AWS_CONFIG_FILE = "${awsConfigDir}/config";
		AWS_SHARED_CREDENTIALS_FILE = "${awsConfigDir}/credentials";
	};
}
