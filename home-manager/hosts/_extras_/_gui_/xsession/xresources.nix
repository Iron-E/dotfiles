{ inputs, outputs, config, lib, pkgs, ... }:
let
	util = outputs.lib;
in {
	imports = [];

	xresources.properties = {
		"Xcursor.theme" = "Bibata-Modern-Classic";

		"rofi.color-enabled" = true;
		"rofi.fake-transparency" = false;
		"rofi.font" = "Ubuntu 12";
		"rofi.fullscreen" = true;
		"rofi.hide-scrollbar" = true;
		"rofi.line-margin" = 5;
		"rofi.location" = 0;
		"rofi.opacity" = 90;
		"rofi.padding" = 130;
		"rofi.separator-style" = "dash";
		"rofi.width" = 1366;
		"rofi.xoffset" = 0;
		"rofi.yoffset" = 0;

		#                     'background', 'border'
		"rofi.color-window" = "argb:dc111111, argb:dc111111";

		# State:                    'bg',           'fg',     'bgalt',        'hlbg',         'hlfg'
		"rofi.color-normal"      = ["argb:00333333" "#ffffff" "argb:00333333" "argb:00333333" "argb:ffefa211"];
		"rofi.color-urgent"      = ["argb:00333333" "#ffffff" "argb:00333333" "argb:00333333" "argb:ffefa211"];
		"rofi.color-active"      = ["argb:00333333" "#ffffff" "argb:00333333" "argb:00333333" "argb:ffefa211"];
	};
}
