{ ... }:
{
  imports = [ ];

  programs.ghostty.settings = {
    shell-integration-features = "no-cursor";
    window-decoration = "server";
  };
}
