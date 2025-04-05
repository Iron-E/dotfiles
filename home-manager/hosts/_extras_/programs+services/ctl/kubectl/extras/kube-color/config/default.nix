{ config, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.sessionVariables.KUBECOLOR_CONFIG = "${config.xdg.configHome}/kubecolor.yml";
  xdg.configFile.${config.home.sessionVariables.KUBECOLOR_CONFIG}.source = ./kubecolor.yaml;
}
