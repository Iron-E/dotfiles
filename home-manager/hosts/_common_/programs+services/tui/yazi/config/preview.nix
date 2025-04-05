{ config, ... }:
{
  imports = [ ];

  programs.yazi.settings.preview = {
    image_filter = "lanczos3";
    image_quality = 50; # 50–90, lower is faster but less accurate
    sixel_fraction = 20; # 10–20, higher is faster but less accurate
    tab_size = config.editorconfig.settings."*".tab_width;
  };
}
