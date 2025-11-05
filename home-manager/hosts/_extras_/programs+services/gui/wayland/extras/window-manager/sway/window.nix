{ ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.window = {
    border = 1;
    titlebar = false;
    hideEdgeBorders = "--i3 none";

    commands = [
      {
        command = "title_window_icon padding 4px";
        criteria.all = true;
      }
    ];
  };
}
