{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  nixpkgs = outputs.lib.config.nixpkgs (with outputs.overlays; [
    additions
    modifications
  ]) { };
}
