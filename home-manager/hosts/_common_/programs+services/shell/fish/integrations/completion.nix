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
        "buf"
        "colima"
        "crane"
        "crictl"
        "dagger"
        "docker"
        "mise"
        "nerdctl"
      ];
    in
    builtins.listToAttrs completions;
}
