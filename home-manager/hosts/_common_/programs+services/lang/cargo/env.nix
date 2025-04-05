{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.CARGO_HOME =
    let
      inherit (config) xdg;
    in
    "${xdg.dataHome}/cargo";
}
