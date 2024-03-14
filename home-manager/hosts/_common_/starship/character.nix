{ ... }: {
	imports = [];

	programs.starship.settings.character = {
		success_symbol = "[❯](bold green_dark)";
		error_symbol = "[❯](bold red)";
		vimcmd_symbol = "[❮](bold green_dark)";
		vimcmd_replace_one_symbol = "[❮](bold pink_light)";
		vimcmd_replace_symbol = "[❮](bold pink_light)";
		vimcmd_visual_symbol = "[❮](bold blue)";
	};
}
