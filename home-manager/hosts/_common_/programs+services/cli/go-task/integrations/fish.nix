{ ... }:
{
  imports = [ ];

  programs.fish.interactiveShellInit = # fish
    ''
      task --completion fish | source
    '';
}
