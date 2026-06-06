{ ... }:
{
  imports = [ ];

  programs.git.settings.user = {
    email = builtins.getEnv "GIT_COMMITTER_EMAIL";
    name = builtins.getEnv "GIT_COMMITTER_NAME";
  };
}
