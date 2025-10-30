{ config, lib, ... }:
{
  imports = [ ../../../../window-manager/sway/lib ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.swayKey) lhs rhs;
          fuzzel = lib.getExe config.programs.fuzzel.package;
        in
        {
          ${lhs.withMod lhs.space} = rhs.exec fuzzel;
        }
      );
}
