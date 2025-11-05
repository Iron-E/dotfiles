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
      modifier = lhs.mod;
      floating.modifier = lhs.mod;
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
        lib.pipe
          [ "left" "right" "up" "down" ]
          [
            (map (
              direction: # string
              let
                keys = [
                  lhs.${direction}
                  config.wayland.windowManager.sway.config.${direction}
                ];
              in
              lib.genAttrs (map lhs.withMod keys) (_: "focus ${direction}")
              // lib.genAttrs (map lhs.withModShift keys) (_: "move ${direction}")
            ))
            lib.mergeAttrsList
          ]
        // {
          # tiling
          ${lhs.withMod "c"} = "focus child"; # focus the child container
          ${lhs.withMod "f"} = "fullscreen toggle"; # enter fullscreen mode for the focused container
          ${lhs.withMod "p"} = "focus parent"; # focus the parent container
          ${lhs.withMod "v"} = "split h"; # split down the vertical axis
          ${lhs.withModShift "s"} = "split v"; # split down the horizontal axis

          # change container layout (stacked, tabbed, toggle split)
          ${lhs.withMod "s"} = "layout toggle split";
          ${lhs.withMod "t"} = "layout tabbed";
          ${lhs.withMod "w"} = "layout stacking";

          # floating
          XF86LaunchA = "floating toggle";
          ${lhs.withModAlt "f"} = "floating toggle";

          ${lhs.withAlt lhs.tab} = "focus mode_toggle"; # change focus between tiling / floating windows

          # killing
          ${lhs.withMod lhs.return} = rhs.exec config.wayland.windowManager.sway.config.terminal;
          ${lhs.withMod "q"} = "kill";

          # Restarting sway
          ${lhs.withModShift "c"} = "reload"; # Reload the configuration file
          ${lhs.withModShift "r"} = "restart"; # Restart sway inplace (preserves your layout/session, can be used to upgrade sway)

          # Exit sway (logs you out of your X session)
          ${lhs.withModShift "q"} =
            rhs.exec "${swayPkg.swaynag} -t warning -m 'Do you really want to exit sway?' -B 'Yes, exit sway' '${swayPkg.swaymsg} exit'";

          # Lock computer
          ${lhs.withModAlt "l"} = rhs.exec "swaylock";

          # Volume
          ${lhs.audio.up} = volume.set "+";
          ${lhs.audio.down} = volume.set "-";
          ${lhs.audio.mute} = volume.toggle;

          # Modes
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
