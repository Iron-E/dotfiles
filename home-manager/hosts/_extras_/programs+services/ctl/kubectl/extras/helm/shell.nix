{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    h = "helm";

    hg = "h get";
    hl = "h history";
    hls = "h list";
    ho = "h rollback";
    hs = "h status";

    hn = "h lint";
    he = "h template";
    ht = "h test";
    hv = "h verify";

    hc = "h create";
    hd = "h dependency";
    hk = "h package";
    hpl = "h pull";
    hp = "h push";

    hu = "h uninstall";
    hi = "h upgrade -i";

    hy = "h registry";
    hr = "h repo";
    hh = "h show";
  };
}
