{ ... }:
{
  imports = [ ];

  programs.git.settings.pull = {
    rebase = true;
  };
}
