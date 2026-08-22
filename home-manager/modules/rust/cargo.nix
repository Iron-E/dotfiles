{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkDefault
    mkEnableOption
    mkIf
    mkMerge
    mkOption
    types
    ;

  cfg = config.programs.rust;
in
{
  options.programs.rust.cargo = {
    enable = mkEnableOption "cargo";

    configToml = mkOption {
      description = "The active fish syntax theme";
      type = types.toml;
      default = {
        build.rustc-wrapper = lib.getExe pkgs.ccache;
        target.x86_64-unknown-linux-gnu = {
          linker = lib.getExe pkgs.clang;
          rustflags = [
            "-C"
            "link-arg=-fuse-ld=${lib.getExe pkgs.mold}"
          ];
        };
      };
    };
  };

  config = mkIf (cfg.enable && cfg.cargo.enable) (mkMerge [
    {
      home.file.".cargo/config.toml".source =
        (pkgs.formats.toml { }).generate "cargo-config"
          cfg.cargo.configToml;
    }

    (mkIf config.xdg.userDirs.enable {
      home.sessionVariables.CARGO_HOME = mkDefault "${config.xdg.dataHome}/cargo";
    })
  ]);
}
