{ outputs, ... }: {
	imports = [];

	programs.starship.settings.jobs = {
		format = outputs.lib.string.concat [
			"[](bg:black fg:gray_darker)"
			"[ $number$symbol ]($style)"
			"[]($style fg:black)"
		];

		style = "bg:gray_darker fg:blue";
	};
}
