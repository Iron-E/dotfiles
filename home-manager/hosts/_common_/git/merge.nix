{ ... }: {
	imports = [];

	programs.git.extraConfig.merge = {
		conflictstyle = "zdiff3";
	};
}
