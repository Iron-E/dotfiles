{
  lib,
  outputs,
  targetPlatform,
  ...
}:
let
  util = outputs.lib;
in
{
  imports =
    if targetPlatform.isNixOS || !(lib.hasSuffix "linux" targetPlatform.architecture) then
      [ ]
    else
      util.fs.readSubmodules ./.;
}
