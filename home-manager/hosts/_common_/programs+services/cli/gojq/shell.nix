{ config, ... }:
{
  imports = [ ];

  home = {
    sessionVariables.GOJQ_COLORS = config.home.sessionVariables.JQ_COLORS;
    shellAliases.jq = "gojq";
  };
}
