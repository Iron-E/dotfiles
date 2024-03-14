{
	inputs,
	outputs,
	lib,
	config,
	pkgs,
	...
}: {
	imports = [];

	programs.git.delta = {
		enable = true;
		options = {
			navigate = true;
			line-numbers = true;

			interactive = {
				keep-plus-minus-markers = false;
			};
		};
	};
}
