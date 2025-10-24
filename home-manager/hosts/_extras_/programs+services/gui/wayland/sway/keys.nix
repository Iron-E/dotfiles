{ config, lib, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config =
    let
      inherit (config.lib.iron-e.sway.key) lhs rhs;
    in
    {
      keybindings = {
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
