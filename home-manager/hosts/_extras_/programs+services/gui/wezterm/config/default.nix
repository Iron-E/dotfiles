{ outputs, pkgs, ...}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = with pkgs.nerd-fonts; [
    jetbrains-mono
    symbols-only
  ];
  programs.wezterm.extraConfig = builtins.readFile ./wezterm.lua;
}
