{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = [ ../../lib ];

  # dependencies for the bars
  home.packages = with pkgs; [
    acpi # battery2
    font-awesome # battery2
    gawk # disk
    lm_sensors # temperature
    networkmanagerapplet # Wi-Fi
    python3 # battery2
  ];

  wayland.windowManager.sway.config.bars =
    let
      color = config.lib.iron-e.swayColor;
    in
    lib.toList {
      colors = {
        inherit (color.preset.inactive) background;
        separator = "#757575";

        focusedWorkspace = color.barPreset { };
        inactiveWorkspace = color.barPreset color.preset.inactive;
        urgentWorkspace = color.barPreset color.preset.urgent;
      };

      fonts = config.wayland.windowManager.sway.config.fonts // {
        size = 13.0;
      };

      position = "top";

      statusCommand = "i3blocks -c ${config.xdg.configHome}/i3blocks/top.conf";
    };
}
