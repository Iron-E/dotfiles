{ lib, pkgs, ... }:
{
  imports = [ ];

  programs.ghostty = lib.optionalAttrs pkgs.stdenv.hostPlatform.isDarwin {
    installBatSyntax = false;
  };
}
