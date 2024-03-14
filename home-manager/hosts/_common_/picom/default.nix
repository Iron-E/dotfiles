{ outputs, ... }: {
	imports = outputs.lib.fs.readPathsExceptDefault ./.;

	services.picom.enable = true;
}
