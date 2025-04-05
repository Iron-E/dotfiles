{
  lib,
  pkgs,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = lib.optionals pkgs.stdenv.isLinux (
    with pkgs;
    [
      k3s
      vcluster
    ]
  );
}
