{ config, lib, ... }:
{
  imports = [ ];

  home.shellAliases =
    let
      inherit (config.programs.git) aliases;
    in
    lib.optionalAttrs (aliases.pwd ? null != null) {
      # TODO: update after:
      # - https://github.com/ajeetdsouza/zoxide/issues/863
      # - https://github.com/ajeetdsouza/zoxide/issues/944
      zg = ''z "$(git pwd)"'';
    };
}
