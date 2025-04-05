{
  lib,
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

  nixgl.prefix = lib.optionalString (!targetPlatform.isNixOS) (
    lib.getExe' pkgs.nixgl.auto.nixGLDefault "nixGL"
  );
}
