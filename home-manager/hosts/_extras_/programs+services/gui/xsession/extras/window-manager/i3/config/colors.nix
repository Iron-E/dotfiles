args@{ ... }:
let
  inherit (import ./lib/colors.nix args) auto presets;
  focusedInactive = auto presets.inactive;
in
{
  imports = [ ];

  xsession.windowManager.i3.config.colors = {
    inherit focusedInactive;
    unfocused = focusedInactive;

    focused = auto { };
    urgent = auto presets.urgent;
  };
}
