{ config, outputs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  home =
    let
      FZF_DEFAULT_OPTS_FILE = "${config.xdg.configHome}/fzf/config";
    in
    {
      sessionVariables = { inherit FZF_DEFAULT_OPTS_FILE; };
      file."${FZF_DEFAULT_OPTS_FILE}".text = # conf
        ''
          --bind='ctrl-z:abort'
          --bind='ctrl-u:unix-line-discard+first'
          --bind='ctrl-w:unix-word-rubout+first'
          --bind='ctrl-a:beginning-of-line'
          --bind='ctrl-f:end-of-line'
          --bind='ctrl-v:toggle-all'
          --bind='ctrl-space:jump'
          --bind='alt-g:first'
          --bind='alt-G:last'
          --bind='f3:toggle-preview-wrap'
          --bind='f4:toggle-preview'
          --bind='alt-d:preview-page-down'
          --bind='alt-u:preview-page-up'
          --tabstop=3
        '';
    };
}
