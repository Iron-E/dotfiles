{ config, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.fonts = {
    names = config.fonts.fontconfig.defaultFonts.serif;
    style = "Regular";
    size = 12.0;
  };
}
