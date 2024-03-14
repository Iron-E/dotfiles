{ outputs, ... }: {
	imports = outputs.lib.fs.readSubmodules ./.;
}
