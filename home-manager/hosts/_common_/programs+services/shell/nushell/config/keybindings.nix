{ ... }:
{
  imports = [ ];

  programs.nushell.settings.keybindings = [
    {
      name = "open_editor";
      modifier = "Alt";
      keycode = "Char_e";
      mode = [
        "emacs"
        "vi_insert"
        "vi_normal"
      ];

      event = {
        send = "OpenEditor";
      };
    }
  ];
}
