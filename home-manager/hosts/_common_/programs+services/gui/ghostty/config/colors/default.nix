{ ... }:
{
  imports = [ ];

  programs.ghostty.settings.theme = "highlite";
  xdg.configFile."ghostty/themes/highlite".source = ./highlite;
}
