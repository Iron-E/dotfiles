{ pkgs, ... }:
{
  imports = [ ];

  programs.ghostty.settings.keybind = [
    "alt+eight=unbind" # goto_tab:8
    "alt+five=unbind" # goto_tab:5
    "alt+four=unbind" # goto_tab:4
    "alt+nine=unbind" # last_tab
    "alt+one=unbind" # goto_tab:1
    "alt+seven=unbind" # goto_tab:7
    "alt+six=unbind" # goto_tab:6
    "alt+three=unbind" # goto_tab:3
    "alt+two=unbind" # goto_tab:2
    "ctrl+,=unbind" # open_config
    "ctrl+alt+down=unbind" # goto_split:down
    "ctrl+alt+left=unbind" # goto_split:left
    "ctrl+alt+right=unbind" # goto_split:right
    "ctrl+alt+up=unbind" # goto_split:up
    "ctrl+page_down=unbind" # next_tab
    "ctrl+page_up=unbind" # previous_tab
    "ctrl+shift+e=unbind" # new_split:down
    "ctrl+shift+enter=unbind" # toggle_split_zoom
    "ctrl+shift+left=unbind" # previous_tab
    "ctrl+shift+o=unbind" # new_split:right
    "ctrl+shift+q=unbind" # quit
    "ctrl+shift+right=unbind" # next_tab
    "ctrl+shift+t=unbind" # new_tab
    "ctrl+shift+tab=unbind" # previous_tab
    "ctrl+shift+w=unbind" # close_tab
    "ctrl+tab=unbind" # next_tab
    "super+ctrl+left_bracket=unbind" # goto_split:previous
    "super+ctrl+right_bracket=unbind" # goto_split:next
    "super+ctrl+shift+down=unbind" # resize_split:down,10
    "super+ctrl+shift+left=unbind" # resize_split:left,10
    "super+ctrl+shift+plus=unbind" # equalize_splits
    "super+ctrl+shift+right=unbind" # resize_split:right,10
    "super+ctrl+shift+up=unbind" # resize_split:up,10
  ];
}
