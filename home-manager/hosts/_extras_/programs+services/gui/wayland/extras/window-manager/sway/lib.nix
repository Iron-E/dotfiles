{ config, lib, ... }:
{
  imports = [ ];

  lib.iron-e.sway = {
    color = rec {
      # generate common color layouts for bars
      barPreset =
        {
          background ? preset.default.background,
          text ? preset.default.text,
          border ? background,
          ...
        }:
        {
          inherit background border text;
        };

      # generate common colors for client.*
      clientPreset =
        colors@{
          indicator ? preset.default.indicator,
          childBorder ? null,
          ...
        }:
        let
          colors' = barPreset colors;
        in
        colors'
        // {
          inherit indicator;
          childBorder = if childBorder == null then colors'.border else childBorder;
        };

      preset = rec {
        default = {
          indicator = "#22ff22";
          text = "#ffffff";
          background = "#af60af";
        };

        inactive = {
          inherit (default) indicator;
          background = "#35353a";
          text = "#c0c0c0";
        };

        urgent = {
          inherit (default) indicator text;
          background = "#a80000";
        };
      };
    };

    key = {
      lhs = rec {
        alt = "Mod1";
        audio.down = "XF86AudioLowerVolume";
        audio.mute = "XF86AudioMute";
        audio.next = "XF86AudioNext";
        audio.pause = "XF86AudioPause";
        audio.play = "XF86AudioPlay";
        audio.prev = "XF86AudioPrev";
        audio.up = "XF86AudioRaiseVolume";
        brightness.keyboard.down = "XF86KbdBrightnessDown";
        brightness.keyboard.up = "XF86KbdBrightnessUp";
        brightness.monitor.down = "XF86MonBrightnessDown";
        brightness.monitor.up = "XF86MonBrightnessUp";
        down = "Down";
        escape = "Escape";
        greater = "greater";
        left = "Left";
        less = "less";
        mod = "Mod4";
        return = "Return";
        right = "Right";
        shift = "Shift";
        space = "space";
        tab = "Tab";
        up = "Up";

        # convert arrow directions to vim directions
        hjkl =
          let
            directions = {
              ${down} = "j";
              ${left} = "h";
              ${right} = "l";
              ${up} = "k";
            };
          in
          direction: # string
          directions.${direction};

        with' =
          modifier: # string
          key: # string
          "${toString modifier}+${toString key}";

        # string -> string
        withAlt = with' alt;

        # string -> string
        withMod = with' mod;

        # string -> string
        withModAlt = with' (withMod alt);

        # string -> string
        withModShift = with' (withMod shift);
      };

      rhs = rec {
        enterMode =
          name: # string
          ''mode "${name}"'';

        exec =
          cmd: # string
          "exec ${cmd}";

        execInBg =
          cmd: # string
          exec "--no-startup-id ${cmd}";
      };
    };

    pkg = lib.genAttrs [ "sway" "swaybar" "swaymsg" "swaynag" ] (
      lib.getExe' config.wayland.windowManager.sway.package
    );
  };
}
