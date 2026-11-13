{ ... }:
{
  imports = [ ];

  programs.ghostty.settings = {
    adjust-underline-position = 2;
    shell-integration-features = "no-cursor";
    window-decoration = "server";
  };
}
