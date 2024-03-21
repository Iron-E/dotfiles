args @ { inputs, outputs, config, lib, pkgs, ... }:
let
	inherit (import ./lib/util.nix args) i3Exe;
	inherit (lib) getExe;

	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [../../../compositor/picom];

	xsession.windowManager.i3.config.startup = map (v: v // { notification = false; }) [
		{ command = "${getExe config.services.picom.package}"; } # compositor
		{ command = "${i3Exe "i3-sensible-terminal"}"; } # start terminal
	];
}
