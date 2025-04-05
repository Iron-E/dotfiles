{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.RANDFILE =
    let
      inherit (config) xdg;
    in
    "${xdg.dataHome}/openssl/rnd";
}
