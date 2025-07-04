{ ... }:
{
  imports = [ ];

  programs.fish.interactiveShellInit = # fish
    ''
      set -g fish_greeting
    '';
}
