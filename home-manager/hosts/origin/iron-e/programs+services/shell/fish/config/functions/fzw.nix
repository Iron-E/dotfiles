{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [
		../../../../../../../_common_/programs+services/shell/fish/config/functions/wd.nix
		./word.nix
	];

	programs.fish.functions.fzw = {
		description = "alias fzw=word --cp (wd /mnt/vaults/words fzf)";
		wraps = "word --cp (wd /mnt/vaults/words fzf)";
		body = multiline /* fish */ ''
			word --cp (wd /mnt/vaults/words ${lib.getExe config.programs.fzf.package}) $argv
		'';
	};
}
