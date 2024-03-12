{ ... }: {
	imports = [];

	programs.bat.enable = true;
	programs.bat.config = {
		italic-text = "always";
		pager = "less -R";
		style = "full";
		theme = "highlite";
	};

	programs.bat.themes = {
		highlite.src = ./highlite.tmTheme;
	};
}
