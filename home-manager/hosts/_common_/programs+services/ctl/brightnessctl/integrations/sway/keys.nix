{
  config,
  pkgs,
  lib,
  ...
}:
{
  imports = [ ];

  wayland.windowManager.sway.config.keybindings =
    lib.optionalAttrs config.wayland.windowManager.sway.enable
      (
        let
          inherit (config.lib.iron-e.sway.key) lhs rhs;
          changeKeyboardBrightness =
            let
              brightnessctl = lib.getExe pkgs.brightnessctl;
            in
            sign: rhs.execInBg ''${brightnessctl} -d "smc::kbd_backlight" set 10%${sign}'';
        in
        {
          ### Turn keyboard brightness up and down
          ${lhs.brightness.keyboard.down} = changeKeyboardBrightness "-";
          ${lhs.brightness.keyboard.up} = changeKeyboardBrightness "+";
        }
      );
}
