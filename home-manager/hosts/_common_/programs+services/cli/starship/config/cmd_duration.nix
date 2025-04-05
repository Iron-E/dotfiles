{ ... }:
{
  imports = [ ];

  programs.starship.settings.cmd_duration = {
    format = "[]($style inverted)[ $duration ]($style)";
    style = "fg:black bg:tan";
  };
}
