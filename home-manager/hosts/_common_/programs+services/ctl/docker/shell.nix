{ ... }:
{
  imports = [ ];

  home.shellAliases = {
    d = "docker";
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
