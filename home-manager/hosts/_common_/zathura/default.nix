{ outputs, ... }: {
	imports = outputs.lib.fs.readSubmodules ./.;

	programs.zathura.enable = true;
}
