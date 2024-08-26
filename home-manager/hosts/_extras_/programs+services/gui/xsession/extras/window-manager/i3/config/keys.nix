args @ { inputs, outputs, config, lib, pkgs, ... }:
let
	inherit (config.xsession.windowManager.i3.config) fonts bars;
	inherit (import ./lib/keys.nix args) exec execInBg lhs lhsMod lhsModAlt lhsModShift mod return space;
	inherit (import ./lib/util.nix args) i3Exe;
	inherit (lib) getExe getExe';

	util = outputs.lib;
	inherit (util.strings) multiline;
in {
	imports = [];

	# NOTE: required for i3-menu-desktop
	home.packages = with pkgs; [dmenu];

	xsession.windowManager.i3.config = {
		modifier = mod;
		keybindings =
		let
			changeBrightness =
			let brightnessctl = getExe pkgs.brightnessctl;
			in {
				monitor = sign: exec "${brightnessctl} set 5%${sign}";
				keyboard = sign: execInBg ''${brightnessctl} -d "smc::kbd_backlight" set 10%${sign}'';
			};

			changeTemparature =
			let redshift = getExe config.services.redshift.package;
			in temp: execInBg "${redshift} -PO ${builtins.toString temp}"
			;

			player =
			let playerctl = getExe config.services.playerctld.package;
			in cmd: execInBg "${playerctl} ${cmd}"
			;

			screenshot = exec "${getExe' pkgs.lxqt.lximage-qt "lximage-qt"} --screenshot";

			volume =
			let
				volume' =
				let
					topBar = lib.findFirst (bar: bar.position == "top") { statusCommand = "i3blocks"; } bars;
					topBarCmd = builtins.elemAt (lib.splitString " " topBar.statusCommand) 0;
				in
				cmd:
					execInBg "amixer -q -D pulse sset Master ${cmd} && ${getExe' pkgs.procps "pkill"} -RTMIN+10 ${topBarCmd}"
				;

			in {
				set = sign: volume' "5%${sign}";
				toggle = volume' "toggle";
			};
		in {
			${lhsMod return} = exec (i3Exe "i3-sensible-terminal"); # start a terminal
			${lhsMod "q"} = "kill"; # kill focused window

			# start dmenu (a program launcher)
			${lhsMod "d"} = exec "${getExe pkgs.bash} ${inputs.i3switch}/switch-window.sh";
			${lhsMod "x"} = exec "${getExe' pkgs.dmenu "dmenu_run"}";
			${lhsMod space} = exec (i3Exe "i3-dmenu-desktop");

			# Restarting i3
			${lhsModShift "c"} = "reload"; # Reload the configuration file
			${lhsModShift "r"} = "restart"; # Restart i3 inplace (preserves your layout/session, can be used to upgrade i3)

			## Exit i3 (logs you out of your X session)
			${lhsModShift "q"} = exec ''
				"${i3Exe "i3-nagbar"} -t warning -m 'Do you really want to exit i3?' -B 'Yes, exit i3' '${i3Exe "i3-msg"} exit'"
			'';

			##-Keybinds-------------------------##

			### Lock computer
			${lhsModAlt "l"} = exec /* sh */ ''
				export XSECURELOCK_COMPOSITE_OBSCURER=0 && xsecurelock'';

			### Media Control
			${lhs "XF86AudioPlay"} = player "play";
			${lhs "XF86AudioPause"} = player "pause";
			${lhs "XF86AudioNext"} = player "next";
			${lhs "XF86AudioPrev"} = player "previous";

			### Screenshot
			${lhs "Print"} = screenshot;
			${lhsMod "XF86Eject"} = screenshot;

			### Set temperature
			${lhsMod "XF86MonBrightnessDown"} = changeTemparature 2000;
			${lhsMod "XF86MonBrightnessUp"} = changeTemparature 3750;
			${lhsModShift "XF86MonBrightnessDown"} = changeTemparature 1300;
			${lhsModShift "XF86MonBrightnessUp"} = changeTemparature 5500;

			### Turn brightness up and down
			${lhs "XF86MonBrightnessDown"} = changeBrightness.monitor "-";
			${lhs "XF86MonBrightnessUp"} = changeBrightness.monitor "+";

			### Turn keyboard brightness up and down
			${lhs "XF86KbdBrightnessDown"} = changeBrightness.keyboard "-";
			${lhs "XF86KbdBrightnessUp"} = changeBrightness.keyboard "+";

			### Volume
			${lhs "XF86AudioRaiseVolume"} = volume.set "+";
			${lhs "XF86AudioLowerVolume"} = volume.set "-";
			${lhs "XF86AudioMute"} = volume.toggle;
		};
	};
}
