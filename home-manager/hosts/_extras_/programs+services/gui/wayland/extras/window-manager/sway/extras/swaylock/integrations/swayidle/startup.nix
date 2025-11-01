{
  config,
  lib,
  ...
}:
{
  services.swayidle.timeouts = [
    {
      timeout = 300;
      command = "swaylock -f";
    }
    {
      timeout = 5;
      command = ''if pgrep -x swaylock; then swaymsg "output * power off"; fi'';
      resumeCommand = ''if pgrep -x swaylock; then swaymsg "output * power on"; fi'';
    }
  ];
}
