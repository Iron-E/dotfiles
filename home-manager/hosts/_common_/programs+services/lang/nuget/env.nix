{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.NUGET_PACKAGES =
    let
      inherit (config) xdg;
    in
    "${xdg.cacheHome}/NuGetPackages";
}
