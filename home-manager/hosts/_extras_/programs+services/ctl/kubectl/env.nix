{ config, ... }:
{
  imports = [ ];

  home.sessionVariables =
    let
      inherit (config) xdg;
    in
    {
      KUBECACHEDIR = "${xdg.cacheHome}/kube";
      KUBECONFIG = "${xdg.configHome}/kube";
    };
}
