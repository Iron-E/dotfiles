{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "layout.${n}") {
    "css.color-mix.enabled" = true;
    "css.has-selector.enabled" = true;
  };
}
