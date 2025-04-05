{ config, ... }:
{
  imports = [ ];

  home.sessionVariables =
    let
      inherit (config) xdg;
    in
    {
      WGETRC = "${xdg.configHome}/wgetrc";
    };
}
