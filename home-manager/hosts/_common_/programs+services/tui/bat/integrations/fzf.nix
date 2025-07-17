{ config, ... }:
{
  imports = [ ];

  programs.fzf.fileWidgetOptions =
    let
      ls = if config.programs.lsd.enable then "lsd" else "ls";
    in
    [
      "--preview='[ -f {} ] && bat -pp --color=always {} || ${ls} -l --color=always {}'"
      "--preview-border=none"
    ];
}
