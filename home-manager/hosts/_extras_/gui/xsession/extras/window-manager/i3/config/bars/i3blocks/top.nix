args @ { inputs, outputs, config, lib, pkgs, ... }:
let
	inherit (lib) concatLines generators toList;

	i3Lib = import ../../lib args;
	inherit (i3Lib.colors) auto' presets;

	util = outputs.lib;
in {
	xsession.windowManager.i3.config.bars = toList {
		colors = {
			inherit (presets.inactive) background;
			separator = "#757575";

			focusedWorkspace = auto' {};
			inactiveWorkspace = auto' presets.inactive;
			urgentWorkspace = auto' presets.urgent;
		};

		fonts = config.xsession.windowManager.i3.config.fonts // { size = 12.0; };
		position = "top";
		statusCommand =
		let
			section = util.attrsets.pair;

			none = "none";
			once = "once";
			pango = "pango";

			iniLines =
				let toIni = generators.toINI {};
				in list: concatLines (map toIni list)
			;

			# an icon for a `section` with `name`
			icon = name: command: section "${name}_icon" {
				inherit command;
				interval = once;
				markup = pango;
				separator = false;
				separator_block_width = 5;
			};
		in
			# i3blocks config file
			#
			# Please see man i3blocks for a complete reference!
			# The man page is also hosted at http://vivien.github.io/i3blocks

			"i3blocks -c ${pkgs.writeText "i3blocks-bar-top" (concatLines [
				# The properties below are applied to every block, but can be overridden.
				# Each block command defaults to the script name to avoid boilerplate.
				(generators.toINIWithGlobalSection {} (section "globalSection" {
					command = "${inputs.i3blocks-contrib}/$BLOCK_NAME/$BLOCK_NAME";
					markup = none;
					separator_block_width = 15;
				}))

				# These are the individual sections
				(iniLines [
					(icon "volume" /* sh */ "echo -e '\uf0f3 '")
					(section "volume" {
						instance = "Master";
						interval = once;
						signal = 10;
					})

					(icon "disk" /* sh */ "echo -e '\uf07c '")
					(section "disk" {
						interval = 240;
					})

					(icon "temperature" /* sh */ "echo -e '\uf2c9'")
					(section "temperature" {
						color = "#01b9ff";
						interval = 30;
					})

					(section "battery2" {
						interval = 30;
						markup = pango;
					})

					(section "date" {
						command = /* sh */ "date '+%Y/%m/%d'";
						interval = 3600;
						separator = false;
						separator_block_width = 10;
					})

					(section "time" {
						command = /* sh */ "date '+%H:%M:%S EST'";
						interval = 30;
					})

					(section "separator" {
						full_text = "";
						interval = once;
						separator = true;
						separator_block_width = 10;
					})

					(section "wifi" {
						command = /* sh */ "nm-applet";
						interval = once;
					})
				])

				"# vim: ft=dosini"
			])}"
		;
	};
}