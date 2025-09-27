{ outputs, inputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.yazi.plugins.relative-motions = inputs.yazi-relative-motions;
}
