{ config, lib, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs (with config; programs.fuzzel.enable && wayland.windowManager.sway.enable)
      (
        let
          inherit (config.lib.iron-e.sway.key) lhs rhs;
          swayr = lib.getExe config.programs.swayr.package;
        in
        {
          # start dmenu (a program launcher)
          ${lhs.withMod "d"} = rhs.exec "${swayr} switch-window";
        }
      );
}
