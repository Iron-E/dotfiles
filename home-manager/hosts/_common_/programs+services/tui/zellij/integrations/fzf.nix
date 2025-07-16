{ config, ... }:
{
  imports = [ ];

  home.file.${config.home.sessionVariables.FZF_DEFAULT_OPTS_FILE}.text = # conf
    ''
      # HACK: the preview doesn't render correctly
      #       for zellij without refreshing
      --bind='start:toggle-preview+toggle-preview'
    '';
}
