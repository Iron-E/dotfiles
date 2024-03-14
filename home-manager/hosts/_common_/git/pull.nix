{ ... }: {
	imports = [];

	programs.git.extraConfig.pull = {
		rebase = true;
	};
}
