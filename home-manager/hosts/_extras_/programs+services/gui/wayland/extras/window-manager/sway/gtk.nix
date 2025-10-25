{ config, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.wrapperFeatures.gtk = config.gtk.enable;
}
