{
  lib,
  inputs,
  outputs,
  pkgs,
  isNixOS ? false,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  targets.genericLinux = lib.optionalAttrs (pkgs.stdenv.isLinux && !isNixOS) {
    enable = true;
    nixGL.packages = inputs.nixgl.packages;
  };
}
