{ config, ... }:
{
  imports = [ ];

  gtk.gtk2.configLocation =
    let
      inherit (config) xdg;
    in
    "${xdg.configHome}/gtk-2.0/gtkrc";
}
