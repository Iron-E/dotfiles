{ pkgs, ... }:
{
  imports = [ ];

  home.pointerCursor = {
    enable = pkgs.stdenv.hostPlatform.isLinux;
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };
}
