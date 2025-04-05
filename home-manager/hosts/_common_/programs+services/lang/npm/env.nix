{ config, ... }:
{
  imports = [ ];

  home =
    let
      inherit (config) xdg;
    in
    {
      sessionPath = [ "${xdg.dataHome}/npm/bin" ];
      sessionVariables.NPM_CONFIG_USERCONFIG = "${xdg.configHome}/npm/npmrc";
    };
}
