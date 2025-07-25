{ config, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home.file.${config.home.sessionVariables.KUBECOLOR_CONFIG}.source = ./kubecolor.yaml;
}
