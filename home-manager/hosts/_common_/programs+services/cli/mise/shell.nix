{ config, lib, ... }:
{
  imports = [ ];

  home.shellAliases.miseg = "mise -C ${lib.strings.escapeShellArg "${config.xdg.configHome}/mise"}";
}
