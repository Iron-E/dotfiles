{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	programs.fish.functions.watchfile = {
		description = "watch file and run when it changes";
		body = multiline /* fish */ ''
			argparse (fish_opt -s n -l interval --required-val) -- $argv

			if [ -n "$_flag_interval" ]
				set -f interval $_flag_interval
			else
				set -f interval 2
			end

			set -f file $argv[1]
			set -f cmd $argv[2..]

			$cmd # run command on start
			while true
				watch --chgexit --differences --interval $interval --no-title ls -lR $file # watch file
				and $cmd # run command if it updates successfully
			end
		'';
	};
}
