{ ... }:
{
  imports = [ ];

  qt.enable = true;
  qt.platformTheme.name = "gtk3"; # “gtk”, “gtk3”, “gnome”, “lxqt”, “qtct”, “kde”
  # qt.style.name = config.gtk.theme.name; # might be needed?
}
