{ ... }: {
	imports = [];

	programs.git.extraConfig.commit = {
		template = "${./message.txt}";
	};
}
