{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  wayland.windowManager.sway.config =
    let
      sway' = config.lib.iron-e.sway;
      inherit (sway'.key) lhs rhs;
    in
    {
      keybindings =
        let
          changeKeyboardBrightness =
            let
              brightnessctl = lib.getExe pkgs.brightnessctl;
            in
            sign: rhs.execInBg ''${brightnessctl} -d "smc::kbd_backlight" set 10%${sign}'';

          player =
            let
              playerctl = lib.getExe config.services.playerctld.package;
            in
            cmd: rhs.execInBg "${playerctl} ${cmd}";

          screenshotRegion = rhs.exec "${lib.getExe pkgs.shotman} -c region";

          volume' =
            let
              inherit (config.wayland.windowManager.sway.config) bars;
              topBar = lib.findFirst (bar: bar.position == "top") { statusCommand = "swayblocks"; } bars;
              topBarArgv = lib.splitString " " topBar.statusCommand;
              topBarArg0 = builtins.elemAt topBarArgv 0;
            in
            cmd: # string
            args: # string
            rhs.execInBg "wpctl ${cmd} @DEFAULT_AUDIO_SINK@ ${args} && ${lib.getExe' pkgs.procps "pkill"} -RTMIN+10 ${topBarArg0}";

          volume = {
            set = sign: volume' "set-volume" "5%${sign} -l 1.0";
            toggle = volume' "set-mute" "toggle";
          };
        in
        {
          ${lhs.withMod lhs.return} = rhs.exec config.wayland.windowManager.sway.config.terminal;
          ${lhs.withMod "q"} = "kill";

          # Restarting sway
          ${lhs.withModShift "c"} = "reload"; # Reload the configuration file
          ${lhs.withModShift "r"} = "restart"; # Restart sway inplace (preserves your layout/session, can be used to upgrade sway)

          ## Exit sway (logs you out of your X session)
          ${lhs.withModShift "q"} =
            rhs.exec "${sway'.pkg.swaynag} -t warning -m 'Do you really want to exit sway?' -B 'Yes, exit sway' '${sway'.pkg.swaymsg} exit'";

          ##-Keybinds-------------------------##

          ### Lock computer
          ${lhs.withModAlt "l"} = rhs.exec "swaylock";

          ### Media Control
          ${lhs.audio.next} = player "next";
          ${lhs.audio.pause} = player "pause";
          ${lhs.audio.play} = player "play";
          ${lhs.audio.prev} = player "previous";

          # ### Screenshot
          Print = screenshotRegion;
          ${lhs.withMod "XF86Eject"} = screenshotRegion;

          ### Turn keyboard brightness up and down
          ${lhs.brightness.keyboard.down} = changeKeyboardBrightness "-";
          ${lhs.brightness.keyboard.up} = changeKeyboardBrightness "+";

          ### Volume
          ${lhs.audio.up} = volume.set "+";
          ${lhs.audio.down} = volume.set "-";
          ${lhs.audio.mute} = volume.toggle;

          ### Modes
          ${lhs.withMod "r"} = rhs.enterMode "resize";
        };

      modes.resize =
        let
          resize = "10 px or 10 ppt";
        in
        rec {
          h = "resize shrink width ${resize}";
          ${lhs.left} = h;

          j = "resize grow height ${resize}";
          ${lhs.down} = j;

          k = "resize shrink height ${resize}";
          ${lhs.up} = k;

          l = "resize grow width ${resize}";
          ${lhs.right} = l;
        }
        # define bindings for leaving the mode
        // lib.genAttrs [ lhs.escape lhs.return (lhs.withMod "r") ] (_: rhs.enterMode "default");
    };
}
