{ ... }:
{
  imports = [ ];

  programs.git.settings = {
    merge = {
      conflictstyle = "zdiff3";
      ff = "no";
    };

    rerere.enabled = true;
  };
}
