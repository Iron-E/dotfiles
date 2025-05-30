{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "reader.${n}") {
    color_scheme = "dark";
    content_width = 4;
    font_size = 6;
    line_height = 5;
  };
}
