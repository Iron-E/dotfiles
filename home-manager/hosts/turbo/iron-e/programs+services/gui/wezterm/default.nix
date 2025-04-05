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

  # HACK: nixgl doesn't work on macos, but we still want to install the config
  programs.wezterm.package = lib.mkForce pkgs.emptyDirectory;
}
