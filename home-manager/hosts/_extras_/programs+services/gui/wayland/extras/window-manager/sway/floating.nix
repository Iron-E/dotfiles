{ config, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.floating = {
    inherit (config.wayland.windowManager.sway.config.window) border titlebar;
    criteria = [
      { class = "Gcolor3"; }
      { class = "Gxmessage"; }
      { window_role = "bubble"; }
      { window_role = "pop-up"; }
      { window_role = "Preferences"; }
      { window_role = "task_dialog"; }
      { window_type = "dialog"; }
      { window_type = "menu"; }
    ];
  };
}
