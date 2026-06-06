{ lib, pkgs, ... }:
{
  imports = [ ];

  services.gpg-agent.pinentry = lib.optionalAttrs (!pkgs.stdenv.isDarwin) {
    # NOTE: requires services.dbus.packages = [ pkgs.gcr ];
    package = pkgs.pinentry-gnome3;
  };
}
