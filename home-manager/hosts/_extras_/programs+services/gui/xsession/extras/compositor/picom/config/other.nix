{ ... }:
{
  imports = [ ];

  # Vertical synchronization: match the refresh rate of the monitor
  services.picom = {
    settings.vsync-use-glfinish = true;
    vSync = true;
  };
}
