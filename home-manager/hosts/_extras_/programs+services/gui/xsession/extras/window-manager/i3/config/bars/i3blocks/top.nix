args@{
  inputs,
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
let
  inherit (lib) concatLines generators toList;

  i3Lib = import ../../lib args;
  inherit (i3Lib.colors) auto' presets;

  util = outputs.lib;
in
{
  # dependencies for the bars
  home.packages = with pkgs; [
    acpi # battery2
    font-awesome # battery2
    gawk # disk
    lm_sensors # temperature
    networkmanagerapplet # Wi-Fi
    python3 # battery2
  ];

  xsession.windowManager.i3.config.bars = toList {
    colors = {
      inherit (presets.inactive) background;
      separator = "#757575";

      focusedWorkspace = auto' { };
      inactiveWorkspace = auto' presets.inactive;
      urgentWorkspace = auto' presets.urgent;
    };

    fonts = config.xsession.windowManager.i3.config.fonts // {
      size = 13.0;
    };

    position = "top";

    statusCommand = "i3blocks -c ${config.xdg.configHome}/i3blocks/top.conf";
  };
}
