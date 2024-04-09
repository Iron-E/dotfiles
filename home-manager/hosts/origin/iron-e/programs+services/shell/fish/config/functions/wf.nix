{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [
		../../../../../../../_common_/programs+services/shell/fish/config/functions/wd.nix
		./word.nix
	];

	programs.fish.functions.wf = {
		description = "(w)ord fuzzy (f)inder";
		body = multiline /* fish */ ''
			set -f _word (wd /mnt/vaults/words ${lib.getExe config.programs.fzf.package})
			if [ (count $_word) -gt 0 ]
				word --cp $_word
			else
				echo "Nothing selected, skipping"
			end
		'';
	};
}
