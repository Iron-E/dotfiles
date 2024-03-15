{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	# WARN: this module is very slow on WSL. set `windows_starship` to fix
	programs.starship.settings.git_status = {
		format = outputs.lib.strings.concat [
			"[("
				" $all_status$ahead_behind[]($style inverted)"
			")]($style)"
		];

		ahead = "\${count}↑ ";
		behind = "\${count}↓ ";
		diverged = "\${behind_count}↓↑\${ahead_count} ";
		conflicted = "\${count} ";
		stashed = "\${count} ";
		deleted = "\${count} ";
		renamed = "\${count} ";
		modified = "\${count} ";
		staged = "\${count} ";
		untracked = "\${count} ";
		style = "bg:orange fg:black";
	};
}
