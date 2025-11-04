{ config, lib, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.startup = lib.mkAfter [
    { command = config.wayland.windowManager.sway.config.terminal; } # start terminal
  ];
}
