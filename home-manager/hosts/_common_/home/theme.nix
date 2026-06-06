{ pkgs, ... }:
{
  imports = [ ];

  home.pointerCursor = {
    enable = pkgs.stdenv.isLinux;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };
}
