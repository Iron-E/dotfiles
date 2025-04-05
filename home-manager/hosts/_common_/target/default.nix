{ outputs, pkgs, ...}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  targets.genericLinux.enable = pkgs.stdenv.isLinux;
}
