{ ... }:
{
  imports = [ ];

  programs.git.settings.diff = {
    algorithm = "histogram";
    colorMoved = "default";
  };
}
