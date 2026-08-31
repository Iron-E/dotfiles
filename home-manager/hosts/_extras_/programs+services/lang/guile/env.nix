{ config, ... }:
{
  imports = [ ];

  home.sessionVariables =
    let
      inherit (config) xdg;
    in
    {
      GUILE_HISTORY = "${xdg.dataHome}/guile/history";
      GUILE_WARN_DEPRECATED = "detailed";
    };
}
