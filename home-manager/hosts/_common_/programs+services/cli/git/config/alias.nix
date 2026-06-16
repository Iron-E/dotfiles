{ lib, ... }:
{
  imports = [ ];

  programs.git.settings.alias = {
    ###############
    # LOG HELPERS #
    ###############

    graph = "log --graph --pretty=format:'%C(#ffb7b7)%h%C(reset bold) %an%C(reset) %s %C(#ff4090)(%cr)%C(bold #ffa6ff)%d%C(reset)' --abbrev-commit --date=relative";

    clog = "log --topo-order --oneline --cherry";

    tlog = "log --topo-order";

    ls = "ls-files";
    ls-added = "diff --name-only --diff-filter=A";
    ls-broken = "diff --name-only --diff-filter=B";
    ls-copied = "diff --name-only --diff-filter=C";
    ls-deleted = "diff --name-only --diff-filter=D";
    ls-modified = "diff --name-only --diff-filter=M";
    ls-renamed = "diff --name-only --diff-filter=R";
    ls-type-changed = "diff --name-only --diff-filter=T";
    ls-unknown = "diff --name-only --diff-filter=X";
    ls-unmerged = "diff --name-only --diff-filter=U";

    # "list diff"
    # list files that were changed in the given commit range.
    # e.g. `g ls-diff HEAD`, or `g ls-diff HEAD~4..`
    ls-diff =
      lib.trim
        # sh
        ''
          ! git diff --name-only "''${@:-HEAD}" #
        '';

    # "list log"
    # list when files were last changed
    ls-log =
      lib.trim # sh
        ''
          ! git ls-tree --abbrev=12 --format '%(objectname)%x09%(path)' "''${@:-HEAD}" #
        '';

    # "list log"
    # list when files were last changed
    ls-log-recurse =
      lib.trim # sh
        ''
          ! git ls-log -tr "''${@:-HEAD}" #
        '';

    lsr = "ls-remote";

    lst = "ls-tree";

    ################
    # PATH HELPERS #
    ################

    # print working directory
    pwd = "rev-parse --show-toplevel";

    ##################
    # BRANCH ALIASES #
    ##################

    main = "symbolic-ref refs/remotes/origin/HEAD --short";

    # "Print (Current) Branch"
    pb = "branch --show-current";

    # Print Origin Branch
    opb = "rev-parse --abbrev-ref '@{push}'";

    # Print Release Branch
    rpb = "! git pb | sed 's/^staging/release/'";

    # Print Staging Branch
    spb = "! git pb | sed 's/^release/staging/'";

    # Print Upstream Branch
    upb = "rev-parse --abbrev-ref '@{upstream}'";

    ##################
    # BRANCH HELPERS #
    ##################

    up =
      lib.trim # sh
        ''
          ! git push --set-upstream origin "$(git pb)"
        '';
  };
}
