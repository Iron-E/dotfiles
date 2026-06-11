{
  config,
  lib,
  ...
}:
let
  inherit (lib)
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.programs.fish;

  themeModule = types.submodule (
    { ... }:
    {
      options = {
        name = mkOption {
          type = with types; str;
          default = "highlite";
          description = "The name of the fish theme to use.";
        };

        source = mkOption {
          type = with types; nullOr path;
          default = ./highlite.theme;
          description = "The source path of the theme.";
        };
      };
    }
  );
in
{
  options.programs.fish = {
    theme = mkOption {
      type = themeModule;
      default = { };
      description = "The active fish syntax theme";
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      programs.fish.interactiveShellInit = # fish
        ''
          fish_config theme choose ${cfg.theme.name}
        '';
    }

    (mkIf (cfg.theme.source != null) {
      xdg.configFile = {
        "fish/themes/${cfg.theme.name}.theme" = { inherit (cfg.theme) source; };
      };
    })
  ]);
}
