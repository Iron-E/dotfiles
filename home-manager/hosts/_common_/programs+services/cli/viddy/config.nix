{
  lib,
  pkgs,
  config,
  ...
}:
{
  imports = [ ];

  xdg.configFile."viddy.toml".source = (pkgs.formats.toml { }).generate "viddy-config" {
    general =
      {
        no_shell = false;
        skip_empty_diffs = false;
        disable_mouse = true;
      }
      // (
        if config.programs.fish.enable then
          {
            shell = "fish";
            shell_options = "--interactive";
          }
        else
          {
            shell = "bash";
            shell_options = "-i";
          }
      );

    keymap = {
      timemachine_go_to_past = "Shift-j";
      timemachine_go_to_more_past = "Ctrl-j";
      timemachine_go_to_oldest = "Ctrl-Shift-j";
      timemachine_go_to_future = "Shift-k";
      timemachine_go_to_more_future = "Ctrl-k";
      timemachine_go_to_now = "Ctrl-Shift-k";
      scroll_left = "h";
      scroll_right = "l";
      scroll_up = "k";
      scroll_down = "j";
      scroll_half_page_up = "Ctrl-u";
      scroll_half_page_down = "Ctrl-d";
      scroll_page_up = "Ctrl-b";
      scroll_page_down = "Ctrl-f";
      scroll_bottom_of_page = "Shift-g";
      scroll_top_of_page = "g g";
    };
  };

  home.file = lib.optionalAttrs pkgs.stdenv.isDarwin {
    "Library/Application Support/viddy.toml".source = config.xdg.configFile."viddy.toml".source;
  };
}
