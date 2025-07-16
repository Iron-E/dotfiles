{ ... }:
{
  programs =
    let
      defaultCommand = "fd";
      changeDirWidgetCommand = "${defaultCommand} -t d";
      fileWidgetCommand = "${defaultCommand}";
    in
    {
      fzf = {
        inherit changeDirWidgetCommand fileWidgetCommand;
        defaultCommand = fileWidgetCommand;
      };
    };
}
