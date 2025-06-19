{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  xdg.configFile."zellij/config.kdl".source = ./config.kdl;
}
