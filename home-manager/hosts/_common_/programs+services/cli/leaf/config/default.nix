{ outputs, pkgs, ... }:
let
  util = outputs.lib;
in
{
  imports = util.fs.readSubmodules ./.;

  xdg.configFile = {
    "leaf/themes/highlite.toml".source = ./highlite.toml;
    "leaf/config.toml".source = (pkgs.formats.toml { }).generate "leaf-config" {
      # All settings are optional. If a setting is missing or the file
      # does not exist, leaf uses its built-in defaults.
      # Command-line arguments always take priority over this file.

      # Color theme
      # Built-in themes: arctic, forest, ocean, solarized-dark
      # Or set this to a custom theme file path.
      # Relative paths are resolved from this config file's directory.
      # Priority: --theme flag > LEAF_THEME > this setting > ocean
      # Default: ocean
      theme = "./themes/highlite.toml";

      # Default editor for Ctrl+E
      # Any editor name available in PATH: nano, vim, nvim, micro,
      # hx, emacs, code, subl, gedit, kate, mousepad, zed, etc.
      #
      # For paths with spaces, just write the path:
      # editor = 'C:\Program Files\Notepad++\notepad++.exe'
      #
      # For paths with spaces AND arguments, use inner quotes:
      # editor = '"C:\Program Files\Notepad++\notepad++.exe" --some-flag'
      #
      # Priority: --editor flag > LEAF_EDITOR > this setting > nano (notepad on Windows)
      editor = "nvim";

      # Maximum content width (number of columns)
      # Limits how wide the rendered content can be.
      # Useful on wide terminals for better readability.
      # Priority: --width flag > LEAF_WIDTH > this setting > terminal width
      # Minimum: 20
      # Default: terminal width (no limit)
      # width = 80

      # Watch mode: automatically reload when the file changes
      # Only applies when opening a file (ignored for stdin)
      # Default: false
      watch = false;

      # Extra file types shown in the file picker
      # Add other extensions to also show them (without the dot).
      # Code files (py, sh, css, html...) get syntax highlighting.
      # Text files (txt, csv, log...) are rendered as plain Markdown.
      # Default: [] (Markdown only)
      extras = [
        "txt"
        "mdx"
      ];
    };
  };
}
