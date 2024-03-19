{ inputs, outputs, config, lib, pkgs, presets ? {}, ... }:
let
	util = outputs.lib;

	defaultPresets =
	let
		indicator = "#22ff22";
		text = "#ffffff";
	in {
		default = {
			inherit indicator text;
			background = "#af60af";
		};

		inactive = {
			inherit indicator;
			background = "#35353a";
			text = "#c0c0c0";
		};

		urgent = {
			inherit indicator text;
			background = "#a80000";
		};
	};

	presets' = lib.recursiveUpdate defaultPresets presets;
	defaultPreset = presets'.default;

	# generate common color layouts for `client` and `bar`
	auto' = { background ? defaultPreset.background, text ? defaultPreset.text, ... }: {
		inherit background;
		inherit text;
		border = background;
	};
in {
	inherit auto';

	# insert the `indicator` along with the preset
	auto = preset @ { indicator ? defaultPreset.indicator, ... }:
		let colors' = auto' preset;
		in colors' // { inherit indicator; childBorder = colors'.border; }
	;

	presets = presets';
}
