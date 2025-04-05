{ ... }:
{
  imports = [ ];

  programs.fish.functions.word = {
    description = "get a password";
    wraps = "ls /mnt/vaults/words/";
    body = # fish
      ''
        argparse (fish_opt -s y -l cp) -- $argv

        set -f file "/mnt/vaults/words/$argv"
        if [ -n "$_flag_cp" ]
          $PAGER $file | xclip -i -selection clipboard
        else
          $PAGER $file
        end
      '';
  };
}
