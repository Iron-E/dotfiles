{ ... }: {
	imports = [];

	programs.bat = {
		enable = true;
		config = {
			italic-text = "always";
			pager = "less -R";
			style = "full";
			theme = "highlite";
		};

		themes = {
			highlite.src = ./highlite.tmTheme;
		};
	};
}
