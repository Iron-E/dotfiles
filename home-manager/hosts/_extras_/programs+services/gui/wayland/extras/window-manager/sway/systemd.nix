{ ... }:
{
  imports = [ ];

  wayland.windowManager.sway.systemd = {
    enable = true;
    dbusImplementation = "broker";
  };
}
