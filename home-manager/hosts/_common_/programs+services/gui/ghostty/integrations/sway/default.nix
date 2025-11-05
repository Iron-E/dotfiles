{
  config,
  lib,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  wayland.windowManager.sway.config.terminal = lib.getExe' config.programs.ghostty.package "ghostty";
}
