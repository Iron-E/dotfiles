{ ... }:
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

    key = rec {
      alt = "Mod1";
      mod = "Mod4";
      shift = "Shift";
      greater = "greater";
      less = "less";
      down = "Down";
      left = "Left";
      right = "Right";
      up = "Up";
      escape = "Escape";
      return = "Return";
      space = "space";
      tab = "Tab";

      lhs =
        modifier: # string
        key: # string
        "${toString modifier}+${toString key}";

      # string -> string
      lhsAlt = lhs alt;

      # string -> string
      lhsMod = lhs mod;

      # string -> string
      lhsModAlt = lhs (lhsMod alt);

      # string -> string
      lhsModShift = lhs (lhsMod shift);
    };
  };
}
