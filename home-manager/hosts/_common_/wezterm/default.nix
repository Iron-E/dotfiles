{
	inputs,
	outputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [];

	programs.wezterm.enable = true;
}
