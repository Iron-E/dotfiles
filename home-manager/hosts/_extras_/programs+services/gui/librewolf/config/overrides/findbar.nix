{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "findbar.${n}") {
    highlightAll = true;
  };
}
