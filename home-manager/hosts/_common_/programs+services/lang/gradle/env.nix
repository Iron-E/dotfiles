{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.GRADLE_USER_HOME =
    let
      inherit (config) xdg;
    in
    "${xdg.dataHome}/gradle";
}
