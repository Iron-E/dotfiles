{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  gtk.enable = !pkgs.stdenv.hostPlatform.isDarwin;
}
