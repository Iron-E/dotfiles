args@{ lib, config, ... }:
let
  inherit (import ./lib/util.nix args) i3Exe;
  inherit (lib) getExe;
in
{
  imports = [ ../../../compositor/picom ];

  xsession.windowManager.i3.config.startup = map (v: v // { notification = false; }) [
    { command = getExe config.services.picom.package; } # compositor
    { command = "${i3Exe "i3-sensible-terminal"}"; } # start terminal
  ];
}
