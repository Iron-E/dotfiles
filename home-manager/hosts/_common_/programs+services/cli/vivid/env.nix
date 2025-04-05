{ pkgs, lib, ... }:
{
  imports = [ ];

  home.sessionVariables.LS_COLORS = "$(${lib.getExe pkgs.vivid} generate ${./highlite.yaml})";
}
