{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "pref.${n}") {
    "privacy.disable_button.cookie_exceptions" = false;
  };
}
