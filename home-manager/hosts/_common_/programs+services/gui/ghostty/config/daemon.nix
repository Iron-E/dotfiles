{ ... }:
{
  imports = [ ];

  programs.ghostty.settings = {
    gtk-single-instance = true;
    linux-cgroup = "single-instance";
  };
}
