{ config, ... }:
{
  imports = [ ];

  home.sessionVariables._JAVA_OPTIONS =
    let
      inherit (config) xdg;
    in
    "-Djava.util.prefs.userRoot=${xdg.configHome}/java";
}
