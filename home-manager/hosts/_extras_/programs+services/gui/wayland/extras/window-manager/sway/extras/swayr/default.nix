{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.swayr = {
    enable = true;
    systemd.enable = true;
  };
}
