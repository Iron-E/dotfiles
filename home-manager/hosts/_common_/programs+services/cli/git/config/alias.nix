{ lib, ... }:
{
  imports = [ ];

  programs.git.settings.alias = {
    graph = "log --graph --pretty=format:'%C(#ffb7b7)%h%C(reset bold) %an%C(reset) %s %C(#ff4090)(%cr)%C(bold #ffa6ff)%d%C(reset)' --abbrev-commit --date=relative";
    main = "symbolic-ref refs/remotes/origin/HEAD --short";

    ls = "ls-files";

    # "list diff"
    # list files that were changed in the given commit range.
    # e.g. `g ls-diff HEAD`, or `g ls-diff HEAD~4..`
    lsd =
      lib.trim
        # sh
        ''
          ! git diff-tree -r --no-commit-id --name-only "''${@:-HEAD}" #
        '';

    # "list log"
    # list when files were last changed
    lsl =
      lib.trim # sh
        ''
          ! git ls-tree --abbrev=12 --format '%(objectname)%x09%(path)' "''${@:-HEAD}" #
        '';

    # "list log"
    # list when files were last changed
    lsla =
      lib.trim # sh
        ''
          ! git lsl -tr "''${@:-HEAD}" #
        '';

    lsr = "ls-remote";

    lst = "ls-tree";

    # "Print (Current) Branch"
    pb = "branch --show-current";

    # Print Origin Branch
    opb = "rev-parse --abbrev-ref '@{upstream}'";

    pwd = "rev-parse --show-toplevel";

    up =
      lib.trim # sh
        ''
          ! git push --set-upstream origin "$(git pb)"
        '';
  };
}
