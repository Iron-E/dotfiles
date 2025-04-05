{ config, ... }:
{
  imports = [ ];

  home =
    let
      inherit (config.home) homeDirectory;
    in
    {
      sessionPath = [ "${homeDirectory}/bin" ];
      sessionVariables.DO_NOT_TRACK = 1;
    };
}
