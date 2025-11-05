{ config, lib, ... }:
{
  imports = [ ../../../../window-manager/sway/lib ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.swayKey) lhs rhs;

          gammarelay =
            cmd: # string
            rhs.execInBg "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay ${cmd}";
        in
        {
          ### Set temperature
          ${lhs.withMod lhs.brightness.monitor.down} = gammarelay "UpdateTemperature n -250";
          ${lhs.withMod lhs.brightness.monitor.up} = gammarelay "UpdateTemperature n 250";

          ### Set gamma
          ${lhs.withCtrl lhs.brightness.monitor.down} = gammarelay "UpdateGamma d 0.1";
          ${lhs.withCtrl lhs.brightness.monitor.up} = gammarelay "UpdateGamma d -0.1";

          ### Turn brightness up and down
          ${lhs.brightness.monitor.down} = gammarelay "UpdateBrightness d -0.1";
          ${lhs.brightness.monitor.up} = gammarelay "UpdateBrightness d 0.1";
        }
      );
}
