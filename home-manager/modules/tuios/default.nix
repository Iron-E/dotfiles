args@{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    mkPackageOption
    types
    ;

  cfg = config.programs.tuios;
in
{
  options.programs.tuios = {
    enable = mkEnableOption "tuios";
    package = mkPackageOption pkgs "tuios" { nullable = true; };
    settings = mkOption {
      type = types.toml;
      default = import ./settings args;
    };

    themes = mkOption {
      type = types.attrsOf types.json;
      default = import ./themes args;
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];
    home.shellAliases.tu = "tuios";
    xdg.configFile =
      (lib.mapAttrs' (
        name: value: lib.nameValuePair "tuios/themes/${name}.json" { text = (builtins.toJSON value); }
      ) cfg.themes)
      // {
        "tuios/config.d/00-home-manager.toml".source = mkIf (cfg.settings != null) (
          (pkgs.formats.toml { }).generate "tuios-config" cfg.settings
        );
      };

  };
}
