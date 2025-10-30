{ config, lib, ... }:
{
  imports = [ ../../lib ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.swayKey) lhs rhs;
        in
        {
          ### Turn keyboard brightness up and down
          ${lhs.withModAlt "l"} = rhs.exec "swaylock";
        }
      );
}
