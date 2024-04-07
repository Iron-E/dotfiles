{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = util.fs.readSubmodules ./.;

	home.activation.linkXsessionToXinitrc = # link xsession with xinit so that startx works
	let
		inherit (config.home) homeDirectory;
		inherit (config.xsession) scriptPath;
	in lib.hm.dag.entryAfter ["linkGeneration"] (multiline /* sh */ ''
		run ln -sf ${homeDirectory}/${scriptPath} ${homeDirectory}/.xinitrc
	'');
}
