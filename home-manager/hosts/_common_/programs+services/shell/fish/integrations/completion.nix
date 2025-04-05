{ lib, ... }:
{
  imports = [ ];

  xdg.configFile =
    let
      mkCompletion =
        program:
        lib.nameValuePair "fish/completions/${program}.fish" {
          text = # fish
            ''
              generate-completion ${program}
            '';
        };

      completions = map mkCompletion [
        "colima"
        "crane"
        "crictl"
        "dagger"
        "docker"
        "nerdctl"
      ];
    in
    builtins.listToAttrs completions;
}
