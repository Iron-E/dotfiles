{ ... }:
{
  imports = [ ];

  programs.nushell.settings = {
    show_banner = false;

    history.file_format = "sqlite";

    edit_mode = "vi";
    cursor_shape = {
      vi_insert = "line";
      vi_normal = "block";
    };

    completions.algorithm = "fuzzy";

    datetime_format.table = "%F %S %Z";
  };
}
