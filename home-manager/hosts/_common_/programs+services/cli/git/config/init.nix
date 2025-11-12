{ ... }:
{
  imports = [ ];

  programs.git.settings.init = {
    defaultBranch = "trunk"; # if only there was a word for the central BRANCH…
  };
}
