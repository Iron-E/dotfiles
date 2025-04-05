{ ... }:
{
  imports = [ ];

  programs.git.extraConfig.diff = {
    algorithm = "histogram";
    colorMoved = "default";
  };
}
