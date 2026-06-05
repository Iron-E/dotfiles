{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  services.playerctld.enable = pkgs.stdenv.isLinux;
}
