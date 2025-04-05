{ pkgs, config, ... }:
{
  imports = [ ];

  home.packages = with pkgs.nerd-fonts; [ open-dyslexic ];
  xsession.windowManager.i3.config.fonts = {
    names = [ "OpenDyslexic Nerd Font" ];
    style = "Regular";
    size = 11.0;
  };
}
