{ outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.k9s.enable = true;
}
