{ ... }:
{
  imports = [ ];

  programs.bat = {
    config.theme = "highlite";
    themes.highlite.src = ./highlite.tmTheme;
  };
}
