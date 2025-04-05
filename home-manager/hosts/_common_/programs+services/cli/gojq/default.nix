{ outputs, pkgs, ...}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.jq = {
    enable = true;
    package = pkgs.gojq;
  };
}
