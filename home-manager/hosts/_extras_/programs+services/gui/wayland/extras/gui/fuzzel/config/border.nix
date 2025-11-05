{ ... }:
{
  imports = [ ];

  programs.fuzzel.settings.border = rec {
    width = 2;
    radius = 5;
    selection-radius = radius;
  };
}
