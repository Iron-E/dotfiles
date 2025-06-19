{ ... }:
{
  imports = [ ];

  programs.zellij = {
    enableBashIntegration = true;
    enableFishIntegration = true;
    enableZshIntegration = true;
  };

  home.shellAliases = {
    zj = "zellij";
    zp = "zpipe";
  };
}
