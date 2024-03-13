{ ... }: {
	imports = [];

	# Fade windows during opacity changes.
	services.picom.fade = true;

	# The time between steps in a fade in milliseconds. (default 10).
	services.picom.fadeDelta = 4;

	# Opacity change between steps while fading in and fading out. (default [0.028 0.03]).
	services.picom.fadeSteps = [0.03 0.03];
}
