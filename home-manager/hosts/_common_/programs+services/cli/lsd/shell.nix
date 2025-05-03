{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    "ls" = "lsd";

    "t" = "lsd --tree";
    "ta" = "t -A";
  };

  # disable conflicting aliases
  programs.lsd = {
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };
}
