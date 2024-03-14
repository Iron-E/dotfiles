{ ... }: {
	imports = [];

	programs.starship.settings.jobs = {
		format =
			"[](bg:black fg:gray_darker)"
			+ "[ $number$symbol ]($style)"
			+ "[]($style fg:black)"
		;

		style = "bg:gray_darker fg:blue";
	};
}
