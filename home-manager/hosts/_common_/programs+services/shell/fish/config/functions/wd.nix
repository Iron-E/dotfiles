{ ... }:
{
  imports = [ ];

  programs.fish.functions.wd = {
    description = "run commands in a directory";
    body = # fish
      ''
        set -l previous_dir $PWD
        if functions -q z # zoxide
          z $argv[1]
        else
          cd $argv[1]
        end

        $argv[2..]

        cd $previous_dir
      '';
  };
}
