{
  inputs,
  pkgs,
  targetPlatform,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  nixGL.packages =
    if (pkgs.stdenv.isLinux && !targetPlatform.isNixOS) then inputs.nixgl.packages else null;
}
