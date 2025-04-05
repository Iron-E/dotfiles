{ pkgs, ... }:
{
  imports = [ ];

  gtk.theme = {
    name = "vimix-dark-beryl";
    package = pkgs.vimix-gtk-theme-beryl;
  };
}
