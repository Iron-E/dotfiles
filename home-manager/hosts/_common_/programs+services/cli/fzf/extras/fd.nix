{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	home.packages = with pkgs; [fd];
	programs.fzf =
	let
		cmd = # the fzf find command
		fsEntryType: # e.g. `f`, `d`, `x`
			"fd -t ${fsEntryType}"
		;

		defaultCommand = cmd "f";
	in {
		inherit defaultCommand;
		changeDirWidgetCommand = cmd "d";
		fileWidgetCommand = defaultCommand;
	};
}
