{ config, ... }:
{
  imports = [ ];

  home =
    let
      inherit (config) xdg;
    in
    {
      sessionPath = [ "${config.home.sessionVariables.GOPATH}/bin" ];
      sessionVariables = {
        GOCACHE = "${xdg.cacheHome}/go/build";
        GOMODCACHE = "${xdg.cacheHome}/go/mod";
        GOPATH = "${xdg.dataHome}/go";
      };
    };
}
