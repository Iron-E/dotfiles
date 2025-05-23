{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    g = "git";

    ga = "g add";
    gA = "ga -A";
    gaa = "ga -A";
    gac = "gaa && gc";
    gacb = "gaa && gcb";
    gacbr = "gacb --and-rebase";
    gap = "ga --patch";

    gb = "g rebase";
    gbi = "gb -i";
    gbia = "gbi --autosquash";
    gbis = "gb --exec 'g commit --amend --no-edit -n -S' -i rebase -i";

    gc = "g commit";
    gca = "gc --amend";

    gcb = "g absorb";
    gcbr = "gcb --and-rebase";

    gcp = "g cherry-pick";

    gd = "g diff";
    gdh = "gd HEAD";
    gds = "gd --stat";
    gdsh = "gds HEAD";

    ge = "g restore";

    gf = "g fetch";
    gfa = "gf --all";

    gg = "g grep";

    gh = "g show";
    ghe = "gh HEAD";

    gl = "g log";
    glg = "gl --graph --pretty=format:'%C(#ffb7b7)%h%C(reset bold) %an%C(reset) %s %C(#ff4090)(%cr)%C(bold #ffa6ff)%d%C(reset)' --abbrev-commit --date=relative";

    gn = "g branch";

    gp = "g push";
    gpl = "g pull";
    gpt = "gp --tags";

    gr = "g reset";

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
  };
}
