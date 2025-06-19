{ ... }:
{
  imports = [ ];

  programs.fish.interactiveShellInit = # fish
    ''
      if command -qs zellij
        zellij setup --generate-completion fish | source
      end
    '';
}
