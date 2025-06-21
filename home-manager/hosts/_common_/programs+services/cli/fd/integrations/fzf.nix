{
  config,
  lib,
  pkgs,
  ...
}:
{
  programs =
    let
      cmd = # the fzf find command
        fsEntryType: # e.g. `f`, `d`, `x`
        "fd -t ${fsEntryType}";

      changeDirWidgetCommand = cmd "d";
      fileWidgetCommand = cmd "f";
    in
    {
      fish.interactiveShellInit = # fish
        ''
          set -g FZF_ALT_C_COMMAND '${changeDirWidgetCommand} --search-path $dir'
          set -g FZF_CTRL_T_COMMAND '${fileWidgetCommand} --search-path $dir'
        '';

      fzf = {
        inherit changeDirWidgetCommand fileWidgetCommand;
        defaultCommand = fileWidgetCommand;
      };
    };
}
