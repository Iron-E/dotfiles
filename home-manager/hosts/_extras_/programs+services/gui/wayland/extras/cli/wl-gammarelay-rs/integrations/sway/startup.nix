{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  wayland.windowManager.sway.config.startup = [
    { command = "--no-startup-id ${lib.getExe pkgs.wl-gammarelay-rs} run"; } # start wl-gammarelay-rs
  ];
}
