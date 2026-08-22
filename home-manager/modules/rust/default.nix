{
  config,
  lib,
  ...
}:
let
  inherit (lib) mkEnableOption;

  cfg = config.programs.rust;
in
{
  imports = [ ./cargo.nix ];

  options.programs.rust = {
    enable = mkEnableOption "rust";
  };

  config = {
    programs.rust.cargo.enable = lib.mkDefault cfg.enable;
  };
}
