{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.swaylock = {
    enable = true;
    package = null;
  };
}
