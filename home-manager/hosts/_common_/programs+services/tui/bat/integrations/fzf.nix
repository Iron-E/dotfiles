{ ... }:
{
  imports = [ ];

  programs.fzf.fileWidgetOptions = [
    "--preview='bat -pp --color=always {}'"
    "--preview-border=none"
  ];
}
