{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    "ls" = "lsd";

    "t" = "lsd --tree";
    "ta" = "t -A";
  };
}
