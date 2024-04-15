{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish = {
		functions.echo_dots = {
			description = "Convert '...' to '../../', etc";
			body = multiline /* fish */ ''
				set -f count (math (string length $argv[1]) - 1)
				string repeat -n $count ../
			'';
		};

		shellAbbrs.dotdot = {
			position = "anywhere";
			regex = "^\\.\\.+$";
			function = "echo_dots";
		};
	};
}
