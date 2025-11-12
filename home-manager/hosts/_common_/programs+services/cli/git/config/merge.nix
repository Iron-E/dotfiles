{ ... }:
{
  imports = [ ];

  programs.git.settings = {
    merge.conflictstyle = "zdiff3";
    rerere.enabled = true;
  };
}
