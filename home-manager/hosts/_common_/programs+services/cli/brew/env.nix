{ pkgs, lib, ... }:
{
  imports = [ ];

  home.sessionSearchVariables.PATH = lib.optional pkgs.stdenv.hostPlatform.isDarwin "/opt/homebrew/bin";
}
