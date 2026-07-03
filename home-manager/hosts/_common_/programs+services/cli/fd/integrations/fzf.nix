{ lib, ... }:
{
  programs.fzf =
    let
      defaultCommand = "fd";
      mkWidgetCommand =
        opts: # string[]
        "${defaultCommand} ${lib.strings.escapeShellArgs opts} $dir";
    in
    {
      inherit defaultCommand;
      fileWidget.fish.command = mkWidgetCommand [ ];
      changeDirWidget.fish.command = mkWidgetCommand [
        "-t"
        "d"
      ];
    };
}
