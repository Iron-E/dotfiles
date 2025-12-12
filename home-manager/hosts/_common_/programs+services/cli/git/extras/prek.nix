{ pkgs, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [ prek ];
}
