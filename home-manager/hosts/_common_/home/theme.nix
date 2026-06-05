{ lib, pkgs, ... }:
{
  imports = [ ];

  home.pointerCursor = lib.optionalAttrs pkgs.stdenv.isLinux {
    name = "Bibata-Modern-Classic";
    package = pkgs.bibata-cursors;
  };
}
