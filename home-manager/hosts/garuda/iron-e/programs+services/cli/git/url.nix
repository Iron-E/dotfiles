{ ... }:
{
  imports = [ ];

  programs.git.settings.url = {
    "git@github.com:".insteadOf = "https://github.com/";
  };
}
