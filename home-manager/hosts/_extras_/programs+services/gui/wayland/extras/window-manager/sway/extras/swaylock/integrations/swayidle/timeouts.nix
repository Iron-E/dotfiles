{
  config,
  lib,
  pkgs,
  ...
}:
{
  imports = [ ../../../../lib ];

  services.swayidle.timeouts =
    let
      inherit (config.lib.iron-e) swayPkg;
      pgrep = lib.getExe' pkgs.procps "pgrep";
    in
    [
      {
        timeout = 300;
        command = "/usr/bin/swaylock -f";
      }
      {
        timeout = 5;
        command = ''if ${pgrep} -x swaylock; then ${swayPkg.swaymsg} "output * power off"; fi'';
        resumeCommand = ''if ${pgrep} -x swaylock; then ${swayPkg.swaymsg} "output * power on"; fi'';
      }
    ];
}
