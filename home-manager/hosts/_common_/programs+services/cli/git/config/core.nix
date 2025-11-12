{ ... }:
{
  imports = [ ];

  programs.git.settings.core = {
    fsmonitor = true;
  };
}
