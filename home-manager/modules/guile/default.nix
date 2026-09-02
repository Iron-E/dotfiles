{
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

  cfg = config.programs.guile;
in
{
  options.programs.guile = {
    enable = mkEnableOption "guile";
    package = mkPackageOption pkgs "guile" { nullable = true; };
    settings = mkOption {
      description = "desc";
      type = types.lines;
      default = builtins.readFile ./guile.scm;
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];
    home.sessionVariables = {
      GUILE_HISTORY = "${config.xdg.dataHome}/guile/history";
      GUILE_WARN_DEPRECATED = "detailed";
    };

    home.file.".guile".text = mkIf (cfg.settings != "") cfg.settings;

    programs.neovim.extraPackages = [ pkgs.guile-lsp-server ];
  };
}
