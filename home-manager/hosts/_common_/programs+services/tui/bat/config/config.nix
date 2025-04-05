{ pkgs, config, ... }:
{
  imports = [ ];

  home.packages = with pkgs; [ less ];
  programs.bat.config = {
    italic-text = "always";
    pager = "less -R";
    style = "full";
  };
}
