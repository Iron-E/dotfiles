{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "middlemouse.${n}") {
    paste = false;
  };
}
