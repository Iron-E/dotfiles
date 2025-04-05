{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.NODE_REPL_HISTORY =
    let
      inherit (config) xdg;
    in
    "${xdg.dataHome}/node_repl_history";
}
