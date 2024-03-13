{ ... }: {
	imports = [];

	services.picom.activeOpacity = 1;
	services.picom.settings.frame-opacity = 1;
	services.picom.inactiveOpacity = 0.90;
	services.picom.menuOpacity = 0.85;
}
