{ pkgs, ... }:
{
  imports = [ ];

  xdg.portal = {
    extraPortals = with pkgs; [
      darkman
      gnome-keyring
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];

    config.sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
      "org.freedesktop.impl.portal.Settings" = [ "darkman" ];
    };
  };
}
