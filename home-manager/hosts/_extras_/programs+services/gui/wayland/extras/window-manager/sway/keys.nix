{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ./lib ];

  wayland.windowManager.sway.config =
    let
      inherit (config.lib.iron-e.swayKey) lhs rhs;
      inherit (config.lib.iron-e) swayPkg;
    in
    {
      keybindings =
        let
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
            rhs.exec "${swayPkg.swaynag} -t warning -m 'Do you really want to exit sway?' -B 'Yes, exit sway' '${swayPkg.swaymsg} exit'";

          ##-Keybinds-------------------------##

          ### Lock computer
          ${lhs.withModAlt "l"} = rhs.exec "swaylock";

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
