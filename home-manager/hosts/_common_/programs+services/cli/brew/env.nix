{ pkgs, lib, ... }:
{
  imports = [ ];

  home.sessionSearchVariables.PATH = lib.optional pkgs.stdenv.isDarwin "/opt/homebrew/bin";
}
