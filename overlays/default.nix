# This file defines overlays
{ ... }: {
	# This one brings our custom packages from the 'pkgs' directory
	additions = final: _prev: import ../pkgs final;

	# This one contains whatever you want to overlay
	# You can change versions, add patches, set compilation flags, anything really.
	# https://nixos.wiki/wiki/Overlays
	modifications = final: prev:
	let
		nerdfont = font: prev.nerdfonts.override { fonts = [font]; };

		vimix-icon = variant: prev.vimix-icon-theme.override { colorVariants = [variant]; };
		vimix-theme = variant: prev.vimix-gtk-themes.override { themeVariants = [variant]; };
	in {
		nerdfonts-jetbrains-mono  = nerdfont "JetBrainsMono";
		nerdfonts-open-dyslexic = nerdfont "OpenDyslexic";
		nerdfonts-symbols = nerdfont "NerdFontsSymbolsOnly";

		vimix-gtk-theme-beryl = vimix-theme "beryl";
		vimix-icon-theme-beryl = vimix-icon "Beryl";

		# example = prev.example.overrideAttrs (oldAttrs: rec {
		# ...
		# });
	};
}
