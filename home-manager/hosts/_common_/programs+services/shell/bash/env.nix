{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.HISTFILE =
    let
      inherit (config) xdg;
    in
    "${xdg.stateHome}/bash/history";
}
