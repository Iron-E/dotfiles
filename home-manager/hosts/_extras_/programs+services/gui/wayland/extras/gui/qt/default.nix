{ pkgs, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = with pkgs; [
    libsForQt5.qt5.qtwayland
    kdePackages.qtwayland
  ];
}
