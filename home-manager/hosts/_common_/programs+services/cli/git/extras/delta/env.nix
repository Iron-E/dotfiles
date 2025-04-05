{ pkgs, lib, ... }:
{
  imports = [ ];

  home.sessionVariables.DELTA_PAGER = "${lib.getExe pkgs.less} -R";
}
