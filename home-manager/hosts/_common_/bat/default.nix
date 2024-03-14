{ outputs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	programs.bat = {
		enable = true;
		config = {
			italic-text = "always";
			pager = "less -R";
			style = "full";
		};
	};
}
