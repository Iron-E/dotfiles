{ pkgs, ... }:
{
  imports = [ ];

  gtk.theme = {
    name = "Vimix-dark-beryl";
    package = pkgs.vimix-gtk-theme-beryl;
  };
}
