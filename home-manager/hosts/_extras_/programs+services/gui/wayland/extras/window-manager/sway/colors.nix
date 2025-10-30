{ config, ... }:
{
  imports = [ ./lib ];

  wayland.windowManager.sway.config.colors =
    let
      color = config.lib.iron-e.swayColor;
      focusedInactive = color.clientPreset color.preset.inactive;
    in
    {
      inherit focusedInactive;

      background = "#202020";
      focused = color.clientPreset { };
      unfocused = focusedInactive;
      urgent = color.clientPreset color.preset.urgent;
    };
}
