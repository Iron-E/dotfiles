{ outputs, ... }: {
	imports = builtins.filter (path: path != ./default.nix) (outputs.lib.fs.readPaths ./.);

	services.picom.enable = true;
}
