{ config, lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings =
    let
      inherit (builtins) head;
      inherit (config.fonts.fontconfig) defaultFonts;
    in
    lib.mapAttrs' (n: lib.nameValuePair "font.${n}") {
      "minimum-size.x-western" = 20;
      "name.monospace.x-western" = head defaultFonts.monospace;
      "name.sans-serif.x-western" = head defaultFonts.sansSerif;
      "name.serif.x-western" = head defaultFonts.serif;
      "size.monospace.x-western" = 14;
      "size.variable.x-western" = 20;
    };
}
