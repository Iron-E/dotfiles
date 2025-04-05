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

  nix.package = lib.mkDefault pkgs.nix;
}
