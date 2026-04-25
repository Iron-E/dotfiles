{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  programs.mise.enable = true;

  # required for auto complete
  home.packages = with pkgs; [ usage ];
}
