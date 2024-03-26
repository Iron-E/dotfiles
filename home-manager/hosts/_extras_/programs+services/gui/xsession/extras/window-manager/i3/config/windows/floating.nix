args @ { inputs, outputs, config, lib, pkgs, ... }:
let
	inherit (import ../lib/keys.nix args) lhsAlt lhsModAlt tab;

	util = outputs.lib;
	inherit (util.attrsets) pair;
	inherit (util.strings) multiline;
in {
	imports = [];

	xsession.windowManager.i3 = {
		config = {
			floating =
			let
				inherit (config.xsession.windowManager.i3.config) modifier window;
			in {
				inherit modifier;
				inherit (window) border;

				criteria = [
					{ class = "Gcolor3"; }
					{ class = "Gxmessage"; }
					{ window_role = "bubble"; }
					{ window_role = "pop-up"; }
					{ window_role = "Preferences"; }
					{ window_role = "task_dialog"; }
					{ window_type = "dialog"; }
					{ window_type = "menu"; }
				];

				titlebar = false;
			};

			keybindings = {
				# toggle tiling / floating
				XF86LaunchA = "floating toggle";
				${lhsModAlt "f"} = "floating toggle";

				# change focus between tiling / floating windows
				${lhsAlt tab} = "focus mode_toggle";
			};
		};

		extraConfig = multiline /* i3config */ ''
			default_floating_border normal ${builtins.toString config.xsession.windowManager.i3.config.floating.border}
		'';
	};
}
