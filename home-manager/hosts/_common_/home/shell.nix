{ lib, pkgs, ... }:
{
  imports = [ ];

  home.shellAliases = {
    # some terminals don't clear history correctly
    clr = "clear && clear";

    # iproute2
    ip = "ip --color";

    # ls
    l = "ls -l";
    la = "l -A";

    # mkdir
    mkdir = "mkdir -p";
  }
  // (lib.optionalAttrs pkgs.stdenv.isDarwin {
    Y = "pbcopy";
    P = "pbpaste";
  });
}
