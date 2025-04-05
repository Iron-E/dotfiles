{ lib, pkgs, ... }:
{
  imports = [ ];

  home.shellAliases.hex = "${lib.getExe pkgs.hexyl}";
}
