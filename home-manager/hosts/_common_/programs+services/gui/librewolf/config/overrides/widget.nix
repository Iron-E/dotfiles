{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "widget.${n}") {
    "content.allow-gtk-dark-theme" = true;
  };
}
