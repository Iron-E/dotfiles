{ inputs, outputs, lib, config, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = outputs.lib.fs.readSubmodules ./.;

	programs.starship = {
		enable = true;

		settings = {
			"$schema" = "https://starship.rs/config-schema.json";
			add_newline = true;
			format = util.strings.join [
				[ "([░▒▓\${directory}](purple_light))" ]

				(lib.optionals config.programs.git.enable [
					"("
						"[ ](fg:black bg:green_dark)"
						"\${git_branch}\${git_commit}\${git_state}"
						"[](fg:green_dark)"
					")"
					"\${git_status}"
				])

				[
					"\${fill}"
					"\${status}\${cmd_duration}\${jobs}\${env_var.NNN}\${env_var.VIM}\${time}"
					"\n\${character}"
				]
			 ];
		};
	};
}
