{ pkgs, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  # e.g. hydra-check $PKG --channel=nixos-unstable
  home.packages = with pkgs; [ hydra-check ];
}
