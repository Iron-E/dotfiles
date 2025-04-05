{ config, ... }:
{
  imports = [ ];

  home.sessionVariables =
    let
      inherit (config) xdg;
    in
    {
      DOCKER_CONFIG = "${xdg.configHome}/docker";
    };
}
