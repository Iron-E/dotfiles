{ config, lib, ... }:
{
  imports = [ ];

  lib.iron-e.swayPkg = lib.genAttrs [ "sway" "swaybar" "swaymsg" "swaynag" ] (
    lib.getExe' config.wayland.windowManager.sway.package
  );
}
