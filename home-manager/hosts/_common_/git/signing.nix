{ config, ... }: {
	imports = [];

	programs.git = {
		# privately load signing info
		includes = [ { path = "${config.xdg.configHome}/git/signing"; } ];

		signing = {
			key = null; # HACK: "The option `programs.git.signing.key' is used but not defined." unless this is here
			signByDefault = true;
		};
	};
}
