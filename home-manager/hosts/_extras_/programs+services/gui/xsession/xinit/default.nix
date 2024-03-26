{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home = {
		activation.linkXsessionToXinitrc = # link xsession with xinit so that startx works
		let
			homeDir = config.home.homeDirectory;
			scriptPath = config.xsession.scriptPath;
		in lib.hm.dag.entryAfter ["writeBoundary"] (multiline /* sh */ ''
			run ln -sf ${homeDir}/${scriptPath} ${homeDir}/.xinitrc
		'');
	};
}
