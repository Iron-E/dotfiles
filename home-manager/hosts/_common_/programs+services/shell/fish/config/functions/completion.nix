{ ... }:
{
  imports = [ ];

  programs.fish.functions.generate-completion = {
    description = "Run the given command's `completion fish` subcommand, if it is in PATH";
    body = # fish
      ''
        if command -qs $argv[1]
          $argv[1] completion fish | source
        end
      '';
  };
}
