{ outputs, ... }: {
	imports = outputs.lib.fs.readPathsExceptDefault ./.;

	programs.zathura.enable = true;
}
