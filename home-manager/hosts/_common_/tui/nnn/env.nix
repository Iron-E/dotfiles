{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	home.sessionVariables = {
		NNN_ARCHIVE = "\\.(7z|bz2|gz|tar|tgz|xz|zip)$";
		NNN_COLORS = "2356";
		NNN_OPTS = "dEo";
	};
}
