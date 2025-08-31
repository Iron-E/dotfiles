{ config, ... }:
{
  imports = [ ];

  xsession.windowManager.i3.config.fonts = {
    names = config.fonts.fontconfig.defaultFonts.serif;
    style = "Regular";
    size = 12.0;
  };
}
