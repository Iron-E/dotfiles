{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    n = "nerdctl";
    nc = "nerdctl container";
    nca = "nerdctl container attach";
    nck = "nerdctl container kill";
    ncl = "nerdctl container ls --all";
    ncn = "nerdctl container prune";
    nco = "nerdctl container stop";
    ncp = "nerdctl container cp";
    ncr = "nerdctl container rm --force";
    ne = "nerdctl exec";
    ni = "nerdctl image";
    nil = "nerdctl image ls";
    nin = "nerdctl image inspect";
    nip = "nerdctl image pull";
    nir = "nerdctl image rm";
    nis = "nerdctl image save";
    nr = "nerdctl run --rm";
    nx = "nerdctl buildx build";
  };
}
