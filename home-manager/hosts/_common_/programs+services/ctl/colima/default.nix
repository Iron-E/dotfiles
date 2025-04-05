{
  lib,
  pkgs,
  outputs,
  ...
}:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.packages = lib.optionals pkgs.stdenv.isDarwin (
    with pkgs;
    [
      colima

      # for docker runtime; nerdctl has env var issues
      docker-buildx
      docker-client
      docker-credential-helpers
    ]
  );
}
