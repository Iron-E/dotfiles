# This file defines overlays
{ ... }: {
	# This one brings our custom packages from the 'pkgs' directory
	additions = final: _prev: import ../pkgs { pkgs = final; };

	# This one contains whatever you want to overlay
	# You can change versions, add patches, set compilation flags, anything really.
	# https://nixos.wiki/wiki/Overlays
	modifications = final: prev:
	let
		nerdfont = font: prev.nerdfonts.override { fonts = [font]; };
		vimix = variant: prev.vimix-gtk-themes.override { themeVariants = [variant]; };
	in {
		nerdfonts-jetbrains-mono  = nerdfont "JetBrainsMono";
		nerdfonts-open-dyslexic = nerdfont "OpenDyslexic";
		nerdfonts-symbols = nerdfont "NerdFontsSymbolsOnly";

		vimix-gtk-beryl-themes = vimix "beryl";

		# example = prev.example.overrideAttrs (oldAttrs: rec {
		# ...
		# });
	};
}
