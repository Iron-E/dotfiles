{ outputs, pkgs, ...}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  # NOTE: requires services.dbus.packages = [ pkgs.gcr ];
  lib.pinentry.package = pkgs.pinentry-gnome3;
}
