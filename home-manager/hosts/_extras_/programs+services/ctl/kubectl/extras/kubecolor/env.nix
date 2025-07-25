{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.KUBECOLOR_CONFIG = "${builtins.dirOf config.home.sessionVariables.KUBECONFIG}/color.yml";
}
