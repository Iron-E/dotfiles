{ ... }:
{
  imports = [ ];

  programs.git.extraConfig.init = {
    defaultBranch = "trunk"; # if only there was a word for the central BRANCH…
  };
}
