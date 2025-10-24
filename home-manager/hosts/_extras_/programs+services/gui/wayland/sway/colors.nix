{ config, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.colors =
    let
      inherit (config.lib.iron-e.sway) color;
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
