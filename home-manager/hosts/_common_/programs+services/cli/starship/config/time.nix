{ ... }:
{
  imports = [ ];

  programs.starship.settings.time = {
    disabled = false;
    format = "[[ $time ]($style)▓▒░]($style inverted)";
    style = "bg:gray fg:black";
  };
}
