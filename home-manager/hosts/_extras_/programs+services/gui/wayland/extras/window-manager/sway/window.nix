{ ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.window = {
    border = 1;
    titlebar = false;

    commands = [
      {
        command = "title_window_icon padding 4px";
        criteria.all = true;
      }
    ];
  };
}
