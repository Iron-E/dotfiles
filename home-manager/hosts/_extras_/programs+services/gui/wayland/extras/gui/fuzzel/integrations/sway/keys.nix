{ config, lib, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.keybindings =
    let
      inherit (config.lib.iron-e.sway.key) lhs rhs;
      fuzzel = lib.getExe config.programs.fuzzel.package;
    in
    {
      ${lhs.withMod lhs.space} = rhs.exec fuzzel;
    };
}
