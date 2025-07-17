{ config, ... }:
{
  imports = [ ];

  # HACK: the preview doesn't render correctly
  #       for zellij without refreshing
  home.file.${config.home.sessionVariables.FZF_DEFAULT_OPTS_FILE}.text = # conf
    ''
      --bind='start:toggle-preview+toggle-preview'
    '';
}
