{ pkgs, ... }:
{
  imports = [ ];

  gtk.font = {
    name = "Ubuntu";
    package = pkgs.ubuntu-sans;
    size = 10;
  };
}
