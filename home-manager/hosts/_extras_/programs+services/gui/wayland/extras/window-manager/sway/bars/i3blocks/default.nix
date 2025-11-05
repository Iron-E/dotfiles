{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = (util.fs.readSubmodules ./.) ++ [
    ./../../../../../../xsession/extras/window-manager/i3/config/bars/i3blocks/default.nix
    ./../../../../../../xsession/extras/window-manager/i3/config/bars/i3blocks/config.nix
  ];
}
