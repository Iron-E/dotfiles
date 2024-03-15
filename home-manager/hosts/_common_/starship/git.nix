{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	programs.starship.settings = lib.mapAttrs' (name: lib.nameValuePair "git_${name}") (lib.optionalAttrs (config.programs.git.enable) {
		branch = {
			format = "[($symbol $branch(:$remote_branch) )]($style)";
			symbol = "";
			style = "bg:green_dark fg:black";
		};

		commit = {
			format = "[( $hash )( $tag )]($style)";
			only_detached = true;
			tag_symbol = "";
			tag_disabled = false;
			style = "bg:green_dark fg:black";
		};

		state = {
			format = outputs.lib.strings.concat [
				"[\\(]($style fg:gray_dark)"
				"[$state( $progress_current/$progress_total)]($style)"
				"[\\) ]($style fg:gray_dark)"
			];

			style = "bg:green_dark fg:black";
		};

		# WARN: this module is very slow on WSL. set `windows_starship` to fix
		status = {
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
	});
}
