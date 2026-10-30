{
  config,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib)
    mkEnableOption
    mkIf
    mkOption
    mkPackageOption
    types
    ;

  cfg = config.programs.tuios;
in
{

  options.programs.tuios = {
    enable = mkEnableOption "tuios";
    package = mkPackageOption pkgs "tuios" { nullable = true; };
    settings = mkOption {
      type = types.toml;
      default = {
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
            sections = "sessions:25,agents";
            # How I hoped this word would never show up in my personal config... had I any choice, it still wouldn't.
            subagent_collapse = "collapsed";
            subagent_hide_finished = "30s";
            subagent_rows = "tree";
          };
        };

        daemon.persist_scrollback = false;
        dock.compact = true;
        hints.alphabet = "asdfjkl;ghzxcvm,./bnqweruiopty";
      };
    };

    themes = mkOption {
      type = types.attrsOf types.json;
      default.highlite = {
        display_name = "highlite";
        dark = true;
        fg = "#c0c0c0";
        bg = "#202020";
        selection_bg = "#d7d7cf";
        cursor = "#959595";
        black = "#202020";
        red = "#A80000";
        green = "#70D533";
        yellow = "#FF8900";
        blue = "#7766FF";
        purple = "#DF50B0";
        cyan = "#60AFFF";
        white = "#C0C0C0";
        bright_black = "#353535";
        bright_red = "#EE4A59";
        bright_green = "#22FF22";
        bright_yellow = "#F0DF33";
        bright_blue = "#2BFF99";
        bright_purple = "#CF55F0";
        bright_cyan = "#33DBC3";
        bright_white = "#FFFFFF";
        chrome = {
          accent = "#af60af";
          accent_bright = "#60afff";
          success = "#22ff22";
          warning = "#eded00";
          error = "#ff8900";
          info = "#ffb7b7";
          surface = "#353535";
          canvas = "#353535";
          panel = "#505050";
          card = "#505050";
          border = {
            unfocused = "#808080";
            copy = "#99ff99";
            multifocus = "#f0af00";
          };
          rule = "#202020";
          dots = {
            close = "#EE4A59";
            minimize = "#F0DF33";
            zoom = "##22FF22";
          };
        };

      };
    };

  };

  config = mkIf cfg.enable {
    home.packages = mkIf (cfg.package != null) [ cfg.package ];
    home.shellAliases.tu = "tuios";
    xdg.configFile =
      (lib.mapAttrs' (
        name: value: lib.nameValuePair "tuios/themes/${name}.json" { text = (builtins.toJSON value); }
      ) cfg.themes)
      // {
        "tuios/config.d/00-home-manager.toml".source = mkIf (cfg.settings != null) (
          (pkgs.formats.toml { }).generate "tuios-config" cfg.settings
        );
      };

  };
}
