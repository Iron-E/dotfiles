{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.zellij.themes.highlite = ./highlite.kdl;
}
