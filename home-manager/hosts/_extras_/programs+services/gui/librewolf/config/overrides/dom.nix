{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "dom.${n}") {
    "forms.autocomplete.formautofill" = false;
    "security.https_only_mode_ever_enabled" = true;
  };
}
