{ pkgs, ... }:
{
  imports = [ ];

  gtk.iconTheme = {
    name = "Vimix-beryl-dark";
    # package = pkgs.vimix-icon-theme-beryl;
    package = pkgs.vimix-icon-theme;
  };
}
