{ pkgs, ... }:
{
  imports = [ ];

  programs.gh.extensions = with pkgs; [ gh-markdown-preview ];
}
