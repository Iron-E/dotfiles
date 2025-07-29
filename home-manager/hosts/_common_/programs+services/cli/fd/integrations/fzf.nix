{ lib, ... }:
{
  programs =
    let
      defaultCommand = "fd";
      mkWidgetCommand = opts: "${defaultCommand} ${lib.concatStringsSep " " opts} $dir";
      fileWidgetCommand = mkWidgetCommand [ ];
      changeDirWidgetCommand = mkWidgetCommand [
        "-t"
        "d"
      ];
    in
    {
      fzf = {
        inherit changeDirWidgetCommand fileWidgetCommand defaultCommand;
      };
    };
}
