{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "accessibility.${n}") {
    "typeaheadfind.flashBar" = 0;
  };
}
