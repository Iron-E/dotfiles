{
  lib,
  outputs,
  pkgs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  xdg.portal = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
    enable = true;
    xdgOpenUsePortal = true;
  };
}
