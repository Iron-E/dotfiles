{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	xdg.configFile."fish/completions/dagger.fish".text = multiline /* fish */ ''
		if command -qs dagger
			dagger completion fish | source
		end
	'';
}
