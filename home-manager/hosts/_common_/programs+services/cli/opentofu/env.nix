{ config, ... }:
{
  imports = [ ];

  home.sessionVariables.TF_PLUGIN_CACHE_DIR = "${config.xdg.cacheHome}/opentofu/plugins";

  xdg.cacheFile."opentofu/plugins/.gitkeep".text = "";
}
