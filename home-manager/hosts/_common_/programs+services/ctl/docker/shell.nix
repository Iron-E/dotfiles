{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    d = "docker";
    dc = "docker container";
    dca = "docker container attach";
    dck = "docker container kill";
    dcl = "docker container ls --all";
    dcn = "docker container prune";
    dco = "docker container stop";
    dcp = "docker container cp";
    dcr = "docker container rm --force";
    de = "docker exec";
    di = "docker image";
    dil = "docker image ls";
    din = "docker image inspect";
    dir = "docker image rm";
    dis = "docker image save";
    dp = "docker pull";
    dr = "docker run --rm";
    dx = "docker buildx build";
  };
}
