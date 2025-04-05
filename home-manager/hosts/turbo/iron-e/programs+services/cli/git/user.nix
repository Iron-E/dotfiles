{ ... }:
{
  imports = [ ];

  programs.git = {
    userEmail = builtins.getEnv "GIT_USER_EMAIL";
    userName = builtins.getEnv "GIT_USER_NAME";
  };
}
