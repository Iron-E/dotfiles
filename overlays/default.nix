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
	in {
		nerdfonts-symbols = nerdfont "NerdFontsSymbolsOnly";
		nerdfonts-open-dyslexic = nerdfont "OpenDyslexic";
		# example = prev.example.overrideAttrs (oldAttrs: rec {
		# ...
		# });
	};
}
