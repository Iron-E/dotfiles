{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "toolkit.${n}") {
    "legacyUserProfileCustomizations.stylesheets" = true;
  };
}
