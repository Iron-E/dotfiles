{ lib, config, ... }:
{
  imports = [ ];

  programs.fish.functions = lib.optionalAttrs config.programs.git.enable {
    gkz = {
      description = "Reads a stream of revisions from stdin and greps ";
      body = # fish
        ''
          set -f result (
            git worktree list \
            | fzf \
              --with-nth "{3}"\t"{1}" \
              --nth "1" \
              --accept-nth "1"
          )

          if [ -n "$result" ]
            cd "$result"
          end
        '';
    };

    git-grep-revs = {
      description = "Reads a stream of revisions from stdin and greps ";
      wraps = "git grep";
      body = # fish
        ''
          while read revision
            git grep $argv $revision && echo
          end
        '';
    };

    git-diff-merge = {
      description = "Get the diff between (the current branch and its origin) and ((the main branch) and (the commit the current branch's origin branched from master))";
      body = # fish
        ''
          argparse (fish_opt -s u -l upstream --required-val) -- $argv

          if [ -n "$_flag_upstream" ]
            set -f upstream $_flag_upstream
          else
            set -f upstream origin
          end

          if [ -n "$argv[1]" ]
            set -f base_branch $argv[1]
          else
            set -f base_branch master
          end

          if [ -n "$argv[2]" ]
            set -f branch $argv[2]
          else
            set -f branch (git branch --show-current)
          end

          set -f merge_base (git merge-base $upstream/$base_branch $upstream/$branch)
          diff -u (git diff $merge_base $upstream/$base_branch | psub) (git diff $upstream/$branch $branch | psub)
        '';
    };
  };
}
