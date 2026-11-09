{ ... }:
let
  open = menu: "open_menu:" + menu;
  menu = title: keys: {
    inherit title;
    inherit keys;
  };

  left = [
    "left"
    "h"
  ];

  down = [
    "down"
    "j"
  ];

  up = [
    "up"
    "k"
  ];

  right = [
    "right"
    "l"
  ];

  pageup = [
    "pageup"
    "ctrl+u"
  ];

  pagedown = [
    "pagedown"
    "ctrl+d"
  ];
in
{
  keybindings = {
    leader_key = "ctrl+shift+w";

    copy_mode = {
      copy_mode_line_start = [ "home" ];
      copy_mode_line_end = [ "end" ];
      edit_scrollback = [ "alt+e" ];
    };

    debug_prefix = {
      debug_prefix_animations = [ ];
      debug_prefix_cache = [ ];
      debug_prefix_cancel = [ ];
      debug_prefix_logs = [ ];
      debug_prefix_showkeys = [ ];
    };

    global = {
      command_palette = [ ];
      launcher = [ ];
      next_workspace = [ "ctrl+tab" ];
      prev_workspace = [ "ctrl+shift+tab" ];
      move_workspace_left = [ "ctrl+alt+i" ];
      move_workspace_right = [ "ctrl+alt+o" ];
      new_workspace = [ "ctrl+shift+t" ];
      toggle_scratch = [ "ctrl+alt+f" ];
    };

    inbox = {
      ${open "inbox_g"} = [ "g" ];
      ${open "inbox_z"} = [ "z" ];
      ${open "inbox_leader"} = [ "\\" ];

      inbox_close = [
        "q"
        "esc"
      ];

      inbox_help = [ "?" ];

      inbox_back = left;
      inbox_down = down;
      inbox_up = up;
      inbox_open = right;

      inbox_go = [ "enter" ];

      inbox_detail_down = [ "ctrl+f" ];
      inbox_detail_up = [ "ctrl+b" ];

      inbox_allow = [ "y" ];
      inbox_allow_always = [ "Y" ];
      inbox_reply = [ "i" ]; # match other reply bindings
      inbox_deny_reason = [ "N" ];

      inbox_settle = [ "d" ];
      inbox_dismiss = [ "D" ];

      inbox_select = [ "/" ];
      inbox_sort = [ "s" ];
      inbox_filter = [ "tab" ];

      inbox_mailbox = [ "m" ];
      inbox_mark = [ "M" ];

      inbox_page_up = pageup;
      inbox_page_down = pagedown;

      inbox_board = [ "t" ];
      inbox_compare = [ "v" ];
      inbox_last = [ "G" ];
      inbox_new_agent = [ "a" ];
      inbox_pass_on = [ ">" ];
      inbox_peek = [ "K" ];
      inbox_resume = [ "space" ];
      inbox_snooze = [ "Z" ];
      inbox_take = [ "x" ];
      inbox_undo = [ "u" ];
      inbox_write = [ "o" ];

      inbox_artifact = [ ];
      inbox_expand = [ ];
      inbox_first = [ ];
      inbox_fold = [ ];
      inbox_next_needs = [ ];
      inbox_region_next = [ ];
      inbox_list_wider = [ ];
      inbox_mark_all = [ ];
      inbox_review = [ ];
      inbox_show_snoozed = [ ];
      inbox_tab_next = [ ];
      inbox_tab_prev = [ ];
      inbox_view_pane = [ ];
    };

    menus.inbox_leader = menu "inbox: \\" {
      inbox_show_snoozed = [ "z" ];
      inbox_review = [ "r" ];
    };

    menus.inbox_g = menu "inbox: g" {
      inbox_first = [ "g" ];
      inbox_artifact = [ "x" ];
      inbox_tab_next = [ "t" ];
      inbox_tab_prev = [ "T" ];
      inbox_view_pane = [ "d" ];
      inbox_mark_all = [ "M" ];
    };

    menus.inbox_z = menu "inbox: z" {
      inbox_expand = [ "a" ];
      inbox_fold = [ "A" ];
    };

    inbox_peek = {
      peek_approve = [ "y" ];
      peek_approve_always = [ "Y" ];
      peek_back = [
        "esc"
        "h"
        "q"
      ];
      peek_deny = [ "n" ];
      peek_go = [ "enter" ];
      peek_read_again = [ "K" ];
      peek_type = [ "o" ];
    };

    layout = {
      ${open "layout_z"} = [ "z" ];
      ${open "layout_leader"} = [ "\\" ];

      terminal_focus_left = left;
      terminal_focus_down = down;
      terminal_focus_up = up;
      terminal_focus_right = right;

      swap_down = [ "J" ];
      swap_left = [ "H" ];
      swap_right = [ "L" ];
      swap_up = [ "K" ];

      preselect_down = [ ];
      preselect_left = [ ];
      preselect_right = [ ];
      preselect_up = [ ];

      rotate_split = [ "r" ];
      split_horizontal = [ "s" ];
      split_vertical = [ "v" ];
      equalize_splits = [ "=" ];

      resize_height_grow = [ "shift+=" ];
      resize_height_shrink = [ "-" ];
      resize_master_grow = [ "<" ];
      resize_master_shrink = [ ">" ];

      snap_fullscreen = [ ];
      snap_left = [ ];
      snap_right = [ ];

      prefix_toggle_sidebar = [ ];
      resize_height_grow_top = [ ];
      resize_height_shrink_top = [ ];
      resize_master_grow_left = [ ];
      toggle_tiling = [ ];
      unsnap = [ ];
    };

    menus.layout_leader = menu "\\" {
      prefix_toggle_sidebar = [ "b" ];
    };

    menus.layout_z = menu "z" {
      resize_height_grow_top = [ "shift+=" ];
      resize_height_shrink_top = [ "-" ];
      resize_master_grow_left = [ "<" ];
      minimize_prefix_restore_all = [ "R" ];
      ${open "layout_z_m"} = [ "m" ];
      ${open "layout_z_r"} = [ "r" ];
    };

    menus.layout_z_m = menu "zm" {
      minimize_prefix_focused = [ "m" ];
      minimize_prefix_restore_1 = [ "1" ];
      minimize_prefix_restore_2 = [ "2" ];
      minimize_prefix_restore_3 = [ "3" ];
      minimize_prefix_restore_4 = [ "4" ];
      minimize_prefix_restore_5 = [ "5" ];
      minimize_prefix_restore_6 = [ "6" ];
      minimize_prefix_restore_7 = [ "7" ];
      minimize_prefix_restore_8 = [ "8" ];
      minimize_prefix_restore_9 = [ "9" ];
    };

    menus.layout_z_r = menu "zr" {
      restore_minimized_1 = [ "1" ];
      restore_minimized_2 = [ "2" ];
      restore_minimized_3 = [ "3" ];
      restore_minimized_4 = [ "4" ];
      restore_minimized_5 = [ "5" ];
      restore_minimized_6 = [ "6" ];
      restore_minimized_7 = [ "7" ];
      restore_minimized_8 = [ "8" ];
      restore_minimized_9 = [ "9" ];
    };

    layout_prefix = {
      ${open "layout_prefix_g"} = [ "g" ];
      ${open "layout_prefix_w"} = [ "w" ];
      ${open "layout_prefix_h"} = left;
      add_master = [ "m" ];
      cycle_master_position = [ "r" ];
      focus_master = [ "'" ];
      layout_prefix_cancel = [ "esc" ];
      layout_prefix_load = [ "<" ];
      layout_prefix_save = [ ">" ];
      remove_master = [ "d" ];
      snap_corner_1 = [ ];
      snap_corner_2 = [ ];
      snap_corner_3 = [ ];
      snap_corner_4 = [ ];

      swap_with_master = [ ];
      resize_height_50 = [ ];
      resize_height_60 = [ ];
      resize_height_70 = [ ];
      resize_height_80 = [ ];
      resize_height_90 = [ ];
      resize_width_50 = [ ];
      resize_width_60 = [ ];
      resize_width_70 = [ ];
      resize_width_80 = [ ];
      resize_width_90 = [ ];
    };

    menus.layout_prefix_g = menu "layout: g" {
      swap_with_master = [ "s" ];
    };

    menus.layout_prefix_h = menu "layout: h" {
      resize_height_50 = [ "5" ];
      resize_height_60 = [ "6" ];
      resize_height_70 = [ "7" ];
      resize_height_80 = [ "8" ];
      resize_height_90 = [ "9" ];
    };

    menus.layout_prefix_w = menu "layout: w" {
      resize_width_50 = [ "5" ];
      resize_width_60 = [ "6" ];
      resize_width_70 = [ "7" ];
      resize_width_80 = [ "8" ];
      resize_width_90 = [ "9" ];
    };

    lists = {
      list_up = up ++ [ "ctrl+k" ];
      list_down = down ++ [ "ctrl+j" ];

      list_page_up = left ++ [
        "pageup"
        "ctrl+h"
        "ctrl+b"
      ];

      list_page_down = right ++ [
        "pagedown"
        "ctrl+l"
        "ctrl+f"
      ];

      list_first = [
        "home"
        "H"
        "ctrl+H"
      ];

      list_last = [
        "end"
        "L"
        "ctrl+L"
      ];
    };

    mail = {
      ${open "mail_g"} = [ "g" ];

      prefix_inbox = [ "a" ];
      mail_back = [
        "h"
        "esc"
        "q"
      ];

      mail_down = down;
      mail_up = up;
      mail_open = right;

      mail_page_down = pagedown;
      mail_page_up = pageup;

      mail_new = [ "o" ];
      mail_reply = [ "i" ];

      mail_focus_pane = [ ];
    };

    menus.mail_g = menu "mail: g" {
      mail_focus_pane = [ "d" ];
    };

    minimize_prefix = {
      minimize_prefix_cancel = [ ];
      minimize_prefix_focused = [ ];
      minimize_prefix_restore_1 = [ ];
      minimize_prefix_restore_2 = [ ];
      minimize_prefix_restore_3 = [ ];
      minimize_prefix_restore_4 = [ ];
      minimize_prefix_restore_5 = [ ];
      minimize_prefix_restore_6 = [ ];
      minimize_prefix_restore_7 = [ ];
      minimize_prefix_restore_8 = [ ];
      minimize_prefix_restore_9 = [ ];
      minimize_prefix_restore_all = [ ];
    };

    mode_control = {
      enter_terminal_mode = [ "i" ];
      enter_window_mode = [ "alt+esc" ];
      open_keybind_presets = [ ];
      open_settings = [ "," ];
      quit = [ "ctrl+shift+alt+q" ];
      toggle_help = [ "?" ];
    };

    prefix_mode = {
      ${open "prefix_mode_leader"} = [ "\\" ];
      ${open "prefix_mode_g"} = [ "g" ];
      ${open "prefix_mode_z"} = [ "z" ];
      ${open "prefix_mode_prev"} = [ "[" ];
      ${open "prefix_mode_next"} = [ "]" ];
      ${open "prefix_mode_last"} = [ "^" ];

      choose_buffer = [ "\"" ];
      paste_buffer = [ "p" ];
      paste_image = [ "P" ];

      launcher = [ ];
      prefix_command_palette = [ ":" ];

      goto_picker = [ "/" ];
      display_panes = [ "space" ];
      pick_path = [ ];

      prefix_select_0 = [ ];
      prefix_select_1 = [ ];
      prefix_select_2 = [ ];
      prefix_select_3 = [ ];
      prefix_select_4 = [ ];
      prefix_select_5 = [ ];
      prefix_select_6 = [ ];
      prefix_select_7 = [ ];
      prefix_select_8 = [ ];
      prefix_select_9 = [ ];

      terminal_focus_left = [ ];
      terminal_focus_down = [ ];
      terminal_focus_up = [ ];
      terminal_focus_right = [ ];

      prefix_rename_window = [ "A" ];

      edit_scrollback = [ "e" ];
      prefix_scrollback = [ ";" ];

      prefix_selection = up;
      hints = [ "y" ];
      hints_all_panes = [ "Y" ];
      nest = [ "Q" ];

      prefix_window = [ ];
      prefix_workspace = [ "w" ];

      new_worktree = [ ];
      prefix_agents_settings = [ ];
      prefix_close_session = [ ];
      prefix_close_window = [ "q" ];
      prefix_debug = [ ];
      prefix_detach = [ ];
      prefix_equalize_splits = [ "=" ];
      prefix_exit_mode = [ "esc" ];
      prefix_explore = [ "b" ];
      prefix_file_search = [ ];
      prefix_fullscreen = [ "f" ];
      prefix_help = [ "?" ];
      prefix_inbox = [ "a" ];
      prefix_keybinds = [ ];
      prefix_layout = right;
      prefix_mail = [ "m" ];
      prefix_minimize = [ ];
      prefix_new_window = [ "n" ];
      prefix_quit = [ ];
      prefix_review = [ ];
      prefix_rotate_split = [ "r" ];
      prefix_screenshot = [ ];
      prefix_settings = [ ];
      prefix_split_horizontal = [ "s" ];
      prefix_split_vertical = [ "v" ];
      prefix_tape = [ ];
      prefix_toggle_other_rail = [ ];
      prefix_toggle_sidebar = [ ];
      prefix_toggle_spotlight = [ ];
      prefix_toggle_tiling = [ ];
      prefix_transfers = [ ];

      toggle_calm = [ ];
      toggle_scratch = [ ];

      prefix_workspace_switcher = [ ];
      prefix_session_switcher = [ ];
      choose_tree = [ ];
      set_note = [ ];
      prev_agent = [ ];
      prev_session = [ ];
      prefix_last_message = [ ];
      prefix_prev_window = [ ];
      next_agent = [ ];
      next_session = [ ];
      prefix_jump_notif = [ ];
      prefix_next_attention = [ ];
      prefix_next_finished = [ ];
      prefix_next_window = [ ];
    };

    menus.prefix_mode_leader = menu "\\" {
      prefix_toggle_sidebar = [ "b" ];
    };

    menus.prefix_mode_g = menu "g" {
      prefix_workspace_switcher = [ "O" ];
      prefix_session_switcher = [ "w" ];
      choose_tree = [ "W" ];
      set_note = [ "A" ];
    };

    menus.prefix_mode_z = menu "z" {
      minimize_prefix_restore_all = [ "R" ];
      ${open "layout_z_m"} = [ "m" ];
      ${open "layout_z_r"} = [ "r" ];
    };

    menus.prefix_mode_prev = menu "[" {
      prev_agent = [ "a" ];
      prev_session = [ "s" ];
      prefix_prev_window = [ "[" ];
    };

    menus.prefix_mode_last = menu "^" {
      prefix_last_message = [ "m" ];
    };

    menus.prefix_mode_next = menu "]" {
      next_agent = [ "a" ];
      next_session = [ "s" ];
      prefix_jump_notif = [ "n" ];
      prefix_next_attention = [ "m" ];
      prefix_next_finished = [ "f" ];
      prefix_next_window = [ "]" ];
    };

    restore_minimized = {
      restore_minimized_1 = [ ];
      restore_minimized_2 = [ ];
      restore_minimized_3 = [ ];
      restore_minimized_4 = [ ];
      restore_minimized_5 = [ ];
      restore_minimized_6 = [ ];
      restore_minimized_7 = [ ];
      restore_minimized_8 = [ ];
      restore_minimized_9 = [ ];
    };

    review = {
      ${open "review_prev"} = [ "[" ];
      ${open "review_next"} = [ "]" ];
      ${open "review_leader"} = [ "\\" ];

      review_undo_stage = [ ];
      review_stage_file = [ ];
      review_stage_hunk = [ ];
      review_unstage_file = [ ];
      review_unstage_hunk = [ ];
      review_prev_file = [ ];
      review_prev_hunk = [ ];
      review_next_file = [ ];
      review_next_hunk = [ ];
    };

    menus.review_leader = menu "review: \\" {
      ${open "review_leader_f"} = [ "f" ];
      ${open "review_leader_h"} = left;
      review_undo_stage = [ "u" ];
    };

    menus.review_leader_f = menu "review: \\f" {
      review_stage_file = [ "s" ];
      review_unstage_file = [ "u" ];
    };

    menus.review_leader_h = menu "review: \\h" {
      review_stage_hunk = [ "s" ];
      review_unstage_hunk = [ "u" ];
    };

    menus.review_prev = menu "review [" {
      review_prev_file = [ "f" ];
      review_prev_hunk = left;
    };

    menus.review_next = menu "review ]" {
      review_next_file = [ "f" ];
      review_next_hunk = left;
    };

    script = {
      script_pause = [ "space" ];
    };

    sidebar = {
      ${open "sidebar_g"} = [ "g" ];
      accent = [ ];

      collapse = left;
      cursor_down = down;
      cursor_up = up;
      expand = right;
      last = [ "G" ];

      activate = [ "enter" ];

      agents_filter = [ "/" ];
      agents_sort = [ "s" ];

      exit = [ "q" ];
      file_search = [ ];
      help = [ "?" ];

      jump_1 = [ "1" ];
      jump_2 = [ "2" ];
      jump_3 = [ "3" ];
      jump_4 = [ "4" ];
      jump_5 = [ "5" ];
      jump_6 = [ "6" ];
      jump_7 = [ "7" ];
      jump_8 = [ "8" ];
      jump_9 = [ "9" ];

      mail = [ "m" ];
      menu = [ "tab" ];

      new_session = [ "n" ];
      new_window = [ ];

      reorder_down = [ "J" ];
      reorder_up = [ "K" ];

      section = [
        "L"
        "H"
      ];

      switch_edge = [ ];

      kill = [ "d" ];

      narrow = [ ">" ];
      widen = [ "<" ];

      first = [ ];
      palette = [ ];
      rename = [ ];
    };

    menus.sidebar_g = menu "sidebar: g" {
      first = [ "g" ];
      palette = [ "w" ];
      rename = [ "A" ];
    };

    sidebar_agents = {
      ${open "sidebar_agents_z"} = [ "z" ];
      agent_cancel_queued = [ "d" ];
      agent_reply = [ "i" ];
      agent_review = [ "r" ];
      agent_snooze = [ "Z" ];
      agent_unread = [ "u" ];

      agent_subagents = [ ];
    };

    menus.sidebar_agents_z = menu "sidebar agents: z" {
      agent_subagents = [ "a" ];
    };

    sidebar_files = {
      file_copy = [ ];
      file_copy_path = [ ];
      file_create = [ ];
      file_cut = [ ];
      file_delete = [ ];
      file_delete_forever = [ ];
      file_edit = [ ];
      file_insert_path = [ ];
      file_open = [ ];
      file_paste = [ ];
      file_quick_look = [ ];
      file_rename = [ ];
      file_send = [ ];
    };

    system = {
      toggle_spotlight = [ ];
    };

    tape_prefix = {
      tape_prefix_cancel = [ ];
      tape_prefix_manager = [ ];
      tape_prefix_record = [ ];
      tape_prefix_review = [ ];
      tape_prefix_stop = [ ];
    };

    terminal_mode = {
      pick_path = [ ];
      terminal_exit_mode = [ "alt+esc" ];
      terminal_focus_left = [ "ctrl+alt+h" ];
      terminal_focus_down = [ "ctrl+alt+j" ];
      terminal_focus_up = [ "ctrl+alt+k" ];
      terminal_focus_right = [ "ctrl+alt+l" ];
      terminal_next_window = [ ];
      terminal_paste_host = [ ];
      terminal_prev_window = [ ];
      terminal_scroll_down = [ ];
      terminal_scroll_page_down = [ ];
      terminal_scroll_page_up = [ ];
      terminal_scroll_up = [ ];
    };

    transfers = {
      transfers_answer = [ ];
      transfers_cancel = [ ];
      transfers_clear = [ ];
      transfers_close = [ ];
      transfers_down = [ ];
      transfers_pause = [ ];
      transfers_retry = [ ];
      transfers_up = [ ];
    };

    window_management = {
      ${open "window_management_prev"} = [ "[" ];
      ${open "window_management_next"} = [ "]" ];
      ${open "window_management_last"} = [ "^" ];

      command_palette = [ ":" ];
      choose_buffer = [ "\"" ];
      launcher = [ "!" ];
      prefix_inbox = [ "a" ];
      prefix_mail = [ "m" ];

      close_window = [ "q" ];
      copy_selection = [ "y" ];
      focus_rail_pane = [ ];
      focus_sidebar = [ "b" ];
      minimize_window = [ ];
      new_session = [ "o" ];
      new_window = [ "n" ];
      rename_window = [ ];
      restore_all = [ ];
      toggle_pip = [ "." ];
      toggle_zoom = [ "f" ];

      mark_pane = [ "M" ];
      join_marked_left = [ "ctrl+h" ];
      join_marked_down = [ "ctrl+j" ];
      join_marked_up = [ "ctrl+k" ];
      join_marked_right = [ "ctrl+l" ];

      select_window_1 = [ ];
      select_window_2 = [ ];
      select_window_3 = [ ];
      select_window_4 = [ ];
      select_window_5 = [ ];
      select_window_6 = [ ];
      select_window_7 = [ ];
      select_window_8 = [ ];
      select_window_9 = [ ];

      start_screensaver = [ ];

      last_pane = [ ];
      last_session = [ ];
      last_workspace = [ ];
      next_agent = [ ];
      next_session = [ ];
      next_window = [ ];
      prev_agent = [ ];
      prev_session = [ ];
      prev_window = [ ];
    };

    menus.window_management_prev = menu "[" {
      prev_agent = [ "a" ];
      prev_session = [ "s" ];
      prev_window = [ "[" ];
    };

    menus.window_management_next = menu "]" {
      next_agent = [ "a" ];
      next_session = [ "s" ];
      next_window = [ "]" ];
    };

    menus.window_management_last = menu "^" {
      last_pane = [ "p" ];
      last_session = [ "s" ];
      last_workspace = [ "w" ];
    };

    window_prefix = {
      window_prefix_cancel = [ ];
      window_prefix_close = [ ];
      window_prefix_float = [ ];
      window_prefix_new = [ ];
      window_prefix_next = [ ];
      window_prefix_prev = [ ];
      window_prefix_rename = [ ];
      window_prefix_tiling = [ ];
    };

    workspace_prefix = {
      workspace_prefix_cancel = [ "esc" ];
      workspace_prefix_move_1 = [ "shift+1" ];
      workspace_prefix_move_2 = [ "shift+2" ];
      workspace_prefix_move_3 = [ "shift+3" ];
      workspace_prefix_move_4 = [ "shift+4" ];
      workspace_prefix_move_5 = [ "shift+5" ];
      workspace_prefix_move_6 = [ "shift+6" ];
      workspace_prefix_move_7 = [ "shift+7" ];
      workspace_prefix_move_8 = [ "shift+8" ];
      workspace_prefix_move_9 = [ "shift+9" ];
      workspace_prefix_rename = [ "A" ];
      workspace_prefix_switch_1 = [ "1" ];
      workspace_prefix_switch_2 = [ "2" ];
      workspace_prefix_switch_3 = [ "3" ];
      workspace_prefix_switch_4 = [ "4" ];
      workspace_prefix_switch_5 = [ "5" ];
      workspace_prefix_switch_6 = [ "6" ];
      workspace_prefix_switch_7 = [ "7" ];
      workspace_prefix_switch_8 = [ "8" ];
      workspace_prefix_switch_9 = [ "9" ];
    };

    workspaces = {
      move_and_follow_1 = [ "ctrl+shift+1" ];
      move_and_follow_2 = [ "ctrl+shift+2" ];
      move_and_follow_3 = [ "ctrl+shift+3" ];
      move_and_follow_4 = [ "ctrl+shift+4" ];
      move_and_follow_5 = [ "ctrl+shift+5" ];
      move_and_follow_6 = [ "ctrl+shift+6" ];
      move_and_follow_7 = [ "ctrl+shift+7" ];
      move_and_follow_8 = [ "ctrl+shift+8" ];
      move_and_follow_9 = [ "ctrl+shift+9" ];
      send_to_workspace_1 = [ "shift+1" ];
      send_to_workspace_2 = [ "shift+2" ];
      send_to_workspace_3 = [ "shift+3" ];
      send_to_workspace_4 = [ "shift+4" ];
      send_to_workspace_5 = [ "shift+5" ];
      send_to_workspace_6 = [ "shift+6" ];
      send_to_workspace_7 = [ "shift+7" ];
      send_to_workspace_8 = [ "shift+8" ];
      send_to_workspace_9 = [ "shift+9" ];
      switch_workspace_1 = [ "1" ];
      switch_workspace_2 = [ "2" ];
      switch_workspace_3 = [ "3" ];
      switch_workspace_4 = [ "4" ];
      switch_workspace_5 = [ "5" ];
      switch_workspace_6 = [ "6" ];
      switch_workspace_7 = [ "7" ];
      switch_workspace_8 = [ "8" ];
      switch_workspace_9 = [ "9" ];
    };
  };
}
