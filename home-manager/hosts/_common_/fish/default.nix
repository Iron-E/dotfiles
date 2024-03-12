{
	inputs,
	outputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [];

	programs.fish.enable = true;
	xdg.configFile.fish.source = ./config;
}
