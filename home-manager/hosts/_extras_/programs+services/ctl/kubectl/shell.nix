{ config, ... }:
{
  imports = [ ];

  home.shellAliases = {
    k = "kubectl";

    ka = "k apply";
    kaf = "k apply -f";

    kat = "k attach";

    kau = "k auth";
    kani = "kau can-i";

    konf = "k config";

    kcp = "k cp";

    kb = "k debug";

    krm = "k delete";
    krmf = "k delete -f";

    kd = "k diff";

    ki = "k describe";

    kv = "k events";

    kh = "k explain";

    kg = "k get";

    kl = "k logs";

    ko = "k rollout";
    koh = "ko history";
    kor = "ko restart";
    kos = "ko status";
    kou = "ko undo";

    kr = "k run";

    kt = "k top";
  };
}
