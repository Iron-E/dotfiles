{ outputs, ... }: {
	imports = outputs.lib.fs.readSubmodules ./.;

	programs.git.enable = true;
	programs.git.extraConfig = {};
}
