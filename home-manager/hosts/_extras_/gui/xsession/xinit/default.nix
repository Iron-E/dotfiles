{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = util.fs.readSubmodules ./.;

	home.file =
	let
		homeDir = config.home.homeDirectory;
		scriptPath = config.xsession.scriptPath;
	in {
		# link xsession with xinit so that startx works
		${scriptPath}.onChange = /* sh */ "ln -sf ${homeDir}/${scriptPath} ${homeDir}/.xinitrc";
	};
}
