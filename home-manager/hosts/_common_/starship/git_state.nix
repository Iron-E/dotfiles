{ ... }: {
	imports = [];

	programs.starship.settings.git_state = {
		format =
			"[\\(]($style fg:gray_dark)"
			+ "[$state( $progress_current/$progress_total)]($style)"
			+ "[\\) ]($style fg:gray_dark)"
		;

		style = "bg:green_dark fg:black";
	};
}
