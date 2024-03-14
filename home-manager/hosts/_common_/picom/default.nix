{ outputs, ... }: {
	imports = outputs.lib.fs.readSubmodules ./.;

	services.picom.enable = true;
}
