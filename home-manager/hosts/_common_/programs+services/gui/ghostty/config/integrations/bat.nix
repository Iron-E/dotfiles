{ lib, pkgs, ... }:
{
  imports = [ ];

  programs.ghostty = lib.optionalAttrs pkgs.stdenv.isDarwin {
    installBatSyntax = false;
  };
}
