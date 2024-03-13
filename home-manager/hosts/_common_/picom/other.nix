{ ... }: {
	imports = [];

	# Vertical synchronization: match the refresh rate of the monitor
	services.picom.vSync = true;
}
