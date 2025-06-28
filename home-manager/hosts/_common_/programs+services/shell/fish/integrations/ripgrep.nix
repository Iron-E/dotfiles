{ lib, config, ... }:
{
  imports = [ ];

  programs.fish.functions = lib.optionalAttrs config.programs.ripgrep.enable {
    sd = {
      description = "Perform a replacement on stdin using ripgrep.";
      wraps = "rg --passthru --replace";
      body = # fish
        ''
          rg --passthru --replace $argv[2..] -- $argv[1]
        '';
    };
  };
}
