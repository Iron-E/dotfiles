{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ];

  wayland.windowManager.sway.config.startup = [
    {
      command = "--no-startup-id ${lib.getExe' pkgs.systemd "systemctl"} --user reload-or-restart kanshi.service"; # reload kanshi
      always = true; # on every sway reload
    }
  ];
}
