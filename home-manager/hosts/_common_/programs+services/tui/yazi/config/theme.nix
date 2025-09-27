{ config, ... }:
{
  imports = [ ];

  programs.yazi.theme.mgr =
    let
      inherit (config.programs) bat;
    in
    {
      syntect_theme = bat.themes.${bat.config.theme}.src;
    };
}
