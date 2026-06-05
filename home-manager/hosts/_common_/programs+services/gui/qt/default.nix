{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  qt = {
    enable = !pkgs.stdenv.isLinux;
    platformTheme.name = "gtk3"; # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
    # style.name = config.gtk.theme.name; # might be needed?
  };
}
