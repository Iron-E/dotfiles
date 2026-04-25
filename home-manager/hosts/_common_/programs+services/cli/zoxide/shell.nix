{ config, lib, ... }:
{
  imports = [ ];

  home.shellAliases =
    let
      inherit (config.programs.git.settings) alias;
    in
    lib.optionalAttrs (alias.pwd ? null != null) {
      # TODO: update after:
      # - https://github.com/ajeetdsouza/zoxide/issues/863
      # - https://github.com/ajeetdsouza/zoxide/issues/944
      zg = ''z "$(git pwd)"'';
    };
}
