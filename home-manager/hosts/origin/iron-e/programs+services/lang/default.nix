{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.janet.enable = true;
  programs.guile.enable = true;
}
