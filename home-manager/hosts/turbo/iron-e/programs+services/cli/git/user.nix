{ ... }:
{
  imports = [ ];

  programs.git.settings.user = {
    email = builtins.getEnv "GIT_USER_EMAIL";
    name = builtins.getEnv "GIT_USER_NAME";
  };
}
