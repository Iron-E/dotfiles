{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "clipboard.${n}") {
    autocopy = false;
  };
}
