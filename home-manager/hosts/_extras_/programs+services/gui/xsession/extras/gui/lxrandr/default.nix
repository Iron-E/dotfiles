{
  lib,
  pkgs,
  config,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = lib.pipe pkgs.lxde.lxrandr [
    config.lib.nixgl.wrap
    lib.toList
  ];
}
