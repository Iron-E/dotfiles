{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = with pkgs; [ less ];
  programs.bat.config = {
    italic-text = "always";
    pager = "less -R -S";
    style = "full";
    wrap = "never";
  };
}
