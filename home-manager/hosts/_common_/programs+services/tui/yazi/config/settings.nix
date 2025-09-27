{ ... }:
{
  imports = [ ];

  programs.yazi.settings.mgr = {
    linemode = "mtime";
    ratio = [
      1
      4
      3
    ];
    scrolloff = 0;
    show_hidden = false;
    show_symlink = true;
    sort_by = "natural";
    sort_dir_first = true;
    sort_reverse = false;
    sort_sensitive = false;
  };
}
