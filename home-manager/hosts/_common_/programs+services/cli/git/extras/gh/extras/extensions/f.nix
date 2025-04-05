{ pkgs, ... }:
{
  imports = [ ];

  programs.gh.extensions = with pkgs; [ gh-f ];
}
