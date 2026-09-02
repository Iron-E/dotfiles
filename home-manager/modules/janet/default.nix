{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkPackageOption
    mkIf
    ;

  cfg = config.programs.janet;
in
{
  options.programs.janet = {
    enable = mkEnableOption "janet";
    package = mkPackageOption pkgs "janet" { nullable = true; };
  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];
  };
}
