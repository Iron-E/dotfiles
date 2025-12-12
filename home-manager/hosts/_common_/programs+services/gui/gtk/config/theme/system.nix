{ pkgs, ... }:
{
  imports = [ ];

  gtk = rec {
    theme = {
      name = "Vimix-dark-beryl";
      package = pkgs.vimix-gtk-theme-beryl;
    };

    gtk4.theme = theme;
  };
}
