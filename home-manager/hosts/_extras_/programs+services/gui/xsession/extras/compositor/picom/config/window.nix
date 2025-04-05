{ config, ... }:
{
  imports = [ ];

  services.picom.wintypes = {
    dock = {
      shadow = false;
    };

    dnd = {
      shadow = false;
    };

    menu = {
      opacity = config.services.picom.menuOpacity;
    };

    tooltip = {
      # fade: Fade the particular type of windows.
      fade = true;

      # shadow: Give those windows shadow
      shadow = false;

      # opacity: Default opacity for the type of windows.
      opacity = 0.75;

      # focus: Whether to always consider windows of this type focused.
      focus = true;
    };
  };
}
