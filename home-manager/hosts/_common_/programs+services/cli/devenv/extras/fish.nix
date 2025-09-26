{ lib, ... }:
{
  imports = [ ];

  programs.fish.functions = {
    mkenvrc =
      let
        envrc = # sh
          ''
            #!/usr/bin/env bash

            eval "$(devenv direnvrc)"

            # You can pass flags to the devenv command
            # For example: use devenv --impure --option services.postgres.enable:bool true
            use devenv
          '';
      in
      {
        description = "Creates an envrc file for devenv";
        body = # fish
          ''
            set -f output .envrc
            if [ -n $argv[1] ]
              set -f output $argv[1]
            end

            if [ -f .envrc ]
              echo .envrc already exists >/dev/stderr
              return 1
            end

            echo ${lib.escapeShellArg envrc} > .envrc
          '';
      };
  };
}
