{ pkgs, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [ pre-commit ];
}
