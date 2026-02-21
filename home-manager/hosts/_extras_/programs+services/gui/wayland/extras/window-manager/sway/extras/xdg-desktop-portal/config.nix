{ pkgs, ... }:
{
  imports = [ ];

  xdg.portal = {
    extraPortals = with pkgs; [
      gnome-keyring
      xdg-desktop-portal-gtk
      xdg-desktop-portal-wlr
    ];

    config.sway = {
      default = [ "gtk" ];
      "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
      "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
      "org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
  };
}
