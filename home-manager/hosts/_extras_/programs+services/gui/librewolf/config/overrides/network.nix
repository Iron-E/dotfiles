{ lib, ... }:
{
  imports = [ ];

  programs.librewolf.settings = lib.mapAttrs' (n: lib.nameValuePair "network.${n}") {
    "connectivity-service.enabled" = false;
    "http.referer.disallowCrossSiteRelaxingDefault.top_navigation" = true;
    "predictor.enabled" = false;
    "prefetch-next" = false;
    "trr.mode" = 3;
    "trr.uri" = "https://mozilla.cloudflare-dns.com/dns-query";
  };
}
