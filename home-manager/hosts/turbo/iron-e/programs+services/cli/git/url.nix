{ ... }:
{
  imports = [ ];

  programs.git.settings.url = {
    "git@gitlab.com".insteadOf = "https://gitlab.com/";
  };
}
