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
    mkMerge
    mkOption
    mkPackageOption
    toList
    types
    ;

  cfg = config.programs.open-policy-agent;

  submodule = m: types.submoduleWith { modules = toList m; };

  lspModule = submodule {
    options = {
      enable = mkOption {
        description = "Whether to enable the regal language server for opa.";
        default = true;
        type = types.bool;
      };

      package = mkPackageOption pkgs "regal" { nullable = true; };
    };
  };
in
{
  options.programs.open-policy-agent = {
    enable = mkEnableOption "open-policy-agent";
    package = mkPackageOption pkgs "open-policy-agent" { nullable = true; };
    lsp = mkOption {
      description = "Configuration for the regal lsp";
      type = lspModule;
      default = { };
    };
  };

  config = mkIf cfg.enable (mkMerge [
    {
      home.packages = mkIf (cfg.package != null) [ cfg.package ];
    }
    (mkIf cfg.lsp.enable {
      programs.neovim.extraPackages = mkIf (cfg.lsp.package != null) [
        cfg.lsp.package
      ];
    })
  ]);
}
