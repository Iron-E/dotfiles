{ ... }:
{
  imports = [ ];

  lib.iron-e.sway = {
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
