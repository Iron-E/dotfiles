{ outputs, ... }: {
	imports = outputs.lib.fs.readSubmodules ./.;

	gtk.enable = true;
}
