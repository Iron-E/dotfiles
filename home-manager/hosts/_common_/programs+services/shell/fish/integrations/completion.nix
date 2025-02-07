{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.configFile =
	let
		mkCompletion = program: lib.nameValuePair "fish/completions/${program}.fish" {
			text = multiline /* fish */ ''
				generate-completion ${program}
			'';
		};

		completions = map mkCompletion ["colima" "crane" "crictl" "dagger" "docker" "nerdctl"];
	in
		builtins.listToAttrs
		completions
	;
}
