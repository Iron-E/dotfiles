{ pkgs, ... }:
{
  imports = [ ];

  gtk.font = {
    name = "Atkinson Hyperlegible Next";
    package = pkgs.atkinson-hyperlegible-next;
    size = 10;
  };
}
