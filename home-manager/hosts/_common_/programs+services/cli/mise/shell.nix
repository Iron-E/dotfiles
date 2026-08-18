{ config, lib, ... }:
{
  imports = [ ];

  home.shellAliases.miseg = "MISE_DEFAULT_CONFIG_FILENAME=config.toml mise -C ${lib.strings.escapeShellArg "${config.xdg.configHome}/mise"}";
}
