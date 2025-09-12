{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = with pkgs; [ go-task ];
}
