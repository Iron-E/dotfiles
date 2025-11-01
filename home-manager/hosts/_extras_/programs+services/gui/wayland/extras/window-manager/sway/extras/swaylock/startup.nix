{ config, ... }:
{
  wayland.windowManager.sway.config.startup = [
    { command = config.wayland.windowManager.sway.config.terminal; } # start terminal
  ];
}
