{ config, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.keybindings =
    let
      inherit (config.lib.iron-e.sway.key) lhs rhs;

      gammarelay =
        cmd: # string
        rhs.execInBg "busctl --user -- call rs.wl-gammarelay / rs.wl.gammarelay ${cmd}";
    in
    {
      ### Set temperature
      ${lhs.withMod lhs.brightness.monitor.down} = gammarelay "UpdateTemperature n -100";
      ${lhs.withMod lhs.brightness.monitor.up} = gammarelay "UpdateTemperature n 100";

      ### Set gamma
      ${lhs.withModShift lhs.brightness.monitor.down} = gammarelay "UpdateGamma d -0.1";
      ${lhs.withModShift lhs.brightness.monitor.up} = gammarelay "UpdateGamma d 0.1";

      ### Turn brightness up and down
      ${lhs.brightness.monitor.down} = gammarelay "UpdateBrightness d -0.1";
      ${lhs.brightness.monitor.up} = gammarelay "UpdateBrightness d 0.1";
    };
}
