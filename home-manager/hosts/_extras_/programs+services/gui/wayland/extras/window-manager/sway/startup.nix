{ config, lib, ... }:
{
  imports = [ ];

  wayland.windowManager.sway.config.startup =
    let
      inherit (config.wayland.windowManager.sway.config) defaultWorkspace terminal;
    in
    lib.mkAfter [
      { command = "swaymsg 'workspace \"${defaultWorkspace}\"; exec ${terminal}'"; } # start terminal
    ];
}
