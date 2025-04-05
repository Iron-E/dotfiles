{ pkgs, lib, ... }:
{
  imports = [ ];

  home.shellAliases.watch = "${lib.getExe pkgs.viddy} --differences --deletion-differences --skip-empty-diffs";
}
