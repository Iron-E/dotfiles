{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    cdg = ''cd "$(git pwd)"'';

    g = "git";

    ga = "g add";
    gA = "ga -A";
    gaa = "ga -A";
    gac = "gaa && gc";
    gacb = "gaa && gcb";
    gacbr = "gacb --and-rebase";
    gai = "ga --interactive";
    gap = "ga --patch";

    gb = "g rebase";
    gba = "gb --abort";
    gbu = "gb --continue";
    gbi = "gb --interactive";
    gbim = "gbi --rebase-merges";
    gbis = "gb --exec 'g commit --amend --no-edit -n -S' -i rebase -i";

    gcy = "g cherry";

    gc = "g commit";
    gca = "gc --amend";
    gcf = "gc --fixup";

    gcb = "g absorb";
    gcbr = "gcb --and-rebase";

    gcp = "g cherry-pick";
    gcpa = "gcp --abort";
    gcpu = "gcp --continue";

    gd = "g diff";
    gdh = "gd HEAD";
    gdr = "g range-diff";
    gds = "gd --stat";
    gdsh = "gds HEAD";

    ge = "g restore";

    gf = "g fetch";
    gfa = "gf --all";

    gg = "g grep";

    gh = "g show";
    ghe = "gh HEAD";

    gl = "g log";
    glc = "g clog";
    glt = "g tlog";
    glg = "g graph";

    gm = "g merge";
    gma = "g merge --abort";
    gmu = "g merge --continue";

    gn = "g branch";
    gnd = "gn -d";
    gnD = "gn -D";

    gp = "g push";
    gpf = "gp --force-with-lease --force-if-includes";
    gpl = "g pull";
    gpt = "gp --tags";
    gptf = "gpt --force";
    gpu = "gp -u";

    gr = "g reset";
    grh = "gr --hard";

    gs = "g status";

    gt = "g stash";
    gta = "gt apply";
    gtd = "gt drop";
    gtl = "gt list";
    gto = "gt pop";
    gtp = "gt --patch";
    gts = "gt show";

    gw = "g switch";
    gwc = "gw -c";
    gwd = "gw -d";

    gk = "g worktree";
    gka = "gk add";
    gkl = "gk list";
    gko = "gk lock";
    gkm = "gk move";
    gkp = "gk prune";
    gkr = "gk remove";
    gke = "gk repair";
    gku = "gk unlock";
  };
}
