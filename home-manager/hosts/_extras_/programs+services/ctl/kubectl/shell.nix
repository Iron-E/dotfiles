{ config, ... }:
{
  imports = [ ];

  home.shellAliases = {
    k = "kubectl";

    ka = "k apply";
    kaf = "k apply -f";
    kak = "k apply -k";

    kat = "k attach";

    kau = "k auth";
    kani = "kau can-i";

    konf = "k config";
    kns = "konf set-context --current --namespace";
    ktx = "konf use-context";

    kcp = "k cp";

    kb = "k debug";

    krm = "k delete";
    krmf = "k delete -f";
    krmk = "k delete -k";

    kd = "k diff";

    ki = "k describe";

    kx = "k exec";

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
