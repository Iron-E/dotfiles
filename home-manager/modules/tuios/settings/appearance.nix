{ ... }:
{
  appearance = {
    animations_enabled = false;
    dim_unfocused = 10;
    focus_wrap = true;
    frame_panels = true;
    link_click = "ctrl";
    max_fps = 1;
    theme = "highlite";
    tiling_scheme = "smart_split";
    window_title_style = "plain";
    zoom_animation = false;

    selection =
      let
        match_bg = "#99ff99";
        match_fg = "#202020";
      in
      {
        bg = "#264f60";
        flash_color = "#99ff99";
        inherit match_bg match_fg;
        search_bg = match_bg;
        search_fg = match_fg;
      };

    sidebar = {
      git_dirty = false;
      file_actions = false;
      file_drag = false;
      sections = "sessions:25,terminals,agents:34";
      show_numbers = true;
      # How I hoped this word would never show up in my personal config... had I any choice, it still wouldn't.
      subagent_collapse = "collapsed";
      subagent_hide_finished = "30s";
      subagent_rows = "tree";
    };
  };

  daemon.persist_scrollback = false;
  dock.compact = true;
  hints.alphabet = "asdfjklghzxcvmbnqweruiopty";
  worktree.path = "{{ repo_path }}/../{{ branch }}";
}
