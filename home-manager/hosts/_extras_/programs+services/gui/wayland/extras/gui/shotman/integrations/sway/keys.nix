{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ../../../../window-manager/sway/lib ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.swayKey) lhs rhs;
          shotman = lib.getExe' pkgs.shotman "shotman";
          screenshotRegion = rhs.exec "${shotman} -c region";
        in
        {
          Print = screenshotRegion;
          ${lhs.withMod "XF86Eject"} = screenshotRegion;
        }
      );
}
