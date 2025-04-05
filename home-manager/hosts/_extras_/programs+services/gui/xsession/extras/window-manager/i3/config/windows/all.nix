{ ... }:
{
  imports = [ ];

  xsession.windowManager.i3.extraConfig = # i3Config
    ''
      for_window [all] title_window_icon padding 4px
    '';
}
