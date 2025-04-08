{ pkgs, lib, ... }:
{
  imports = [ ];

  home.shellAliases.watch = builtins.concatStringsSep " " [
    (lib.getExe pkgs.viddy)
    "--differences"
    "--skip-empty-diffs"
  ];
}
