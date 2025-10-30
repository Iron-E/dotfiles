{ ... }:
{
  imports = [ ];

  lib.iron-e.swayKey = {
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
      ctrl = "Control";
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
      withCtrl = with' ctrl;

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
}
