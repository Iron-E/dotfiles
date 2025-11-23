{ ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.window = {
    border = 1;
    titlebar = false;
    hideEdgeBorders = "--i3 none";
  };
}
