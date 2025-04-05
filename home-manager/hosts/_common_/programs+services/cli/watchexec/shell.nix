{ pkgs, lib, ... }:
{
  imports = [ ];

  home.shellAliases.fx = "${lib.getExe pkgs.watchexec}";
}
