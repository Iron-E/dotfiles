{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "extensions.${n}") {
    activeThemeID = "firefox-compact-dark@mozilla.org";
  };
}
