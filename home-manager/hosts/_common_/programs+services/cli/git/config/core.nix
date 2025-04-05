{ ... }:
{
  imports = [ ];

  programs.git.extraConfig.core = {
    fsmonitor = true;
  };
}
